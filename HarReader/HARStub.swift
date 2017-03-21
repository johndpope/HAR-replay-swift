//
//  HARStub.swift
//  HarReader
//
//  Created by Pope, John on 3/20/17.
//  Copyright © 2017 John Pope. All rights reserved.
//

import Foundation


import Foundation
import UIKit
import OHHTTPStubs
import SwiftyJSON

@objc class HARStub: NSObject {
    
    
    static let enableHttpStubbing = HARStub()
    
    override init() {
        HARStub.stubHTTP() // N.B. when enabling do a clean
    }
    
    
    // dig up urls / status codes and payloads
    class func stubHarFile(fileName:String)-> ([Dictionary<String, String>]){
        
        stubHTTP()
        let myUrlDictArray: [Dictionary<String, String>] = digoutUrlsStatusCodesPayloads(fileName: fileName)
        HARStub.stubHarResponseForContentArray(harDump: myUrlDictArray)
        return myUrlDictArray
        
    }
    
    
    class func digoutUrlsStatusCodesPayloads(fileName:String)-> ([Dictionary<String, String>]){
        
        var myUrlDictArray: [Dictionary<String, String>] = []
        
        do {
            
            var fileName = fileName
            if fileName.contains("har") {
                fileName = fileName.components(separatedBy: ".")[0]
            }
            
            let path = Bundle.main.path(forResource:fileName, ofType: "har")
            let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
            
            let json = JSON(data: data!)
            
            
            let log = json["log"]
            var d0 = Dictionary<String, String>()
            
            if let entries = log["entries"].array{
                for entry in entries{
                    
                    
                    let requestMethod =  entry["request"]["method"]
                    if (requestMethod == "POST") {
                        // TODO
                        continue
                    }
                    
                    if let urlRequest = entry["request"]["url"].rawString(){
                        d0["url"] = urlRequest
                        if let status = entry["response"]["status"].rawString(){
                            d0["status"] = status
                        }
                        
                        
                        if let jsonPayload = entry["response"]["content"]["text"].string {
                            if let _ = entry["response"]["content"]["encoding"].string {
                                let jsonPayloadUncompressed = CodeTools.gZipDecompressAndBase64String(jsonPayload)
                                d0["payload"] = jsonPayloadUncompressed
                                
                            }else{
                                d0["payload"] = jsonPayload
                            }
                            myUrlDictArray.append(d0)
                        }else{
                            print("WARNING: no response / content / text detected for url:",urlRequest)
                        }
                    }

                }
            }
        } catch {
            print(error)
        }
        
        return myUrlDictArray
        
        
    }
    class func stubHTTP() {
        
        OHHTTPStubs.setEnabled(true)
        OHHTTPStubs.onStubActivation { (request: URLRequest, stub: OHHTTPStubsDescriptor, response: OHHTTPStubsResponse) in
            if let url = request.url{
                print("[OHHTTPStubs] Request to \(url) has been stubbed stub:",stub.name )
            }
        }
        OHHTTPStubs.removeAllStubs()
    }
    
    
    class func stubHarResponseForContentArray(harDump:[Dictionary<String, String>]){
        
        for d0 in harDump {
            if let url = d0["url"] {
                
                
                do{
                    
                    if let payload = d0["payload"]{
                        if let statusCode = d0["status"]{
                            //print("payload:",payload)
                            if let responseData = payload.data(using: .utf8){
                                
                                
                                OHHTTPStubs.stubRequests(passingTest: { (request) -> Bool in
                                    
                                    if let absoluteURL = request.url?.absoluteString{
                                        return( absoluteURL == url )
                                    }
                                    
                                    return false
                                    
                                }) { (request) -> OHHTTPStubsResponse in
                                    if let url = request.url?.absoluteString{
                                        print("INFO:mocking local json:",url)
                                    }
                                    
                                    let code = Int32(statusCode)
                                    return OHHTTPStubsResponse(data:responseData , statusCode:code!  , headers: ["Content-Type" : "application/json"])
                                    }.name = "HAR Stubbed URLS"
                        }
                        
                        }else{
                            print("WARNING: no payload detected")
                        }
                       
                    }else{
                        print("WARNING: no payload detected")
                    }
                    
                    
                    
                }catch  let jsonerror as NSError {
                    print("exception",jsonerror)
                }
            }
        }
    }
    
    
    
}
