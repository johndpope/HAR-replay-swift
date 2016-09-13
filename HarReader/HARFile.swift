//
//  HARFile.swift
//  HarReader
//
//  Created by John Pope on 8/26/16.
//  Copyright © 2016 John Pope. All rights reserved.
//

import Foundation
import Decodable


struct HARArchive {
    let log:HARLog
}

struct HARLog {
    let version:String
    let creator:HARCreator
    let browser:AnyObject?
    var pages:Array<HARPages>
    let entries:Array<HAREntry>
    let comment:String
}

struct HARCreator {
    let version:String
    let name:String
    let comment:String?
}



struct HARPages {
    let startedDateTime:String
    let id:String
    let title:String
    let pageTimings:Array<HARPageTimings>
    let comment:String?
}

struct HARPageTimings {
    let onContentLoad:String
    let onLoad:String
    let comment:String?
}



struct HAREntry {
    let version:String
    let name:String
    let comment:String?
}

/*
 
 let name:String
 
 let pageref:String
 let time:String
 let request:String
 let response:String
 let cache:String
 let timings:String
 let serverIPAddress:String
 let connection:String
 let method:String
 let url:String
 let httpVersion:String
 let cookies:String
 let headers:String
 let queryString:String
 let postData:String
 let headersSize:String
 let bodySize:String
 let status:String
 let statusText:String
 let content:String
 let redirectURL:String
 
 
 }*/

extension HARArchive: Decodable {
    static func decode(j: AnyObject) throws -> HARArchive {
        return try HARArchive(
        log:HARLog(
            version: j => "version",
            creator: HARCreator( version: j => "nested" => "creator",
                        name: j => "name",
                        comment: j => "comment"),
            browser: j => "browser",
            pages: [HARPages(startedDateTime:"",
                id:"",
                title: "",
                pageTimings: [HARPageTimings(onContentLoad:"",
                    onLoad: "",
                    comment: "")],
                comment:  "") ],
            entries: [HAREntry(version:"",name:"",comment:"")],
            comment: j => "comment"
        )
        )
    }
}