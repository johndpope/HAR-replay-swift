//
//  ViewController.swift
//  HarReader
//
//  Created by John Pope on 8/26/16.
//  Copyright © 2016 John Pope. All rights reserved.
//

import UIKit
import Decodable
import SwiftyJSON

// See here how to save http traffic via Charles
//https://gist.github.com/jjarava/5f26806bba75d052c41a

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        do {
            let path = NSBundle.mainBundle().pathForResource("openlab", ofType: "har")
            let data = NSData(contentsOfFile: path!)
 
            let json = JSON(data: data!)
            //print("json:",json)
            let log = json["log"]
            if let entries = log["entries"].array{
                for entry in entries{
                    let response = entry["response"]
                    if let jsonPayload = response["content"]["text"].string {
                        if let _ = response["content"]["encoding"].string {
                            let jsonPayloadUncompressed = CodeTools.GZipDecompressAndBase64String(jsonPayload)
                     
                            print("info:",jsonPayloadUncompressed)
                            
                        }else{
                           // let result = JSON.parse(jsonPayload)
                            print("info:",jsonPayload)
                        }
                        
                        
                    }
                }
            }
        } catch {
            print(error)
        }

    }

   

}

