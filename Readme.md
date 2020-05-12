## *Saving* HAR HTTP-Archive files from Charles / Dump your traffic

![](787-progression.gif)


This library combines OHHTTPStubs + SwiftyJSON to provide a mock server in 1 line.   
Let OHTTPStubs replay your traffic eg. openlab.har

Snapshot your API for playback later on / for unit tests or troubleshooting test captures. 

```swift

usage HARStub.stubHarFile(fileName: "openlab")


// To remove stubs
 OHHTTPStubs.removeAllStubs()
 
 
example with Alamofire 

 let stubbedPayload: [Dictionary<String, String>] = HARStub.stubHarFile(fileName: "openlab")
        for d0 in stubbedPayload {
            // Go offline - and watch it replay!
            if let url = d0["url"] {
                print("url:",url)
                Alamofire.request(url).response { response in
                    print("Request: \(response.request)")
                    print("Response: \(response.response)")
                    print("Error: \(response.error)")
                    
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Data: \(utf8Text)")
                    }
                }
                
            }
        }
 ```




## *Consuming* HAR files
The HAR files allow for analysis at a later time of the session(s) that have been recorded.

As to how to "visualise" the HAR files, below are some options:

### HAR Viewer
Developed by the author of the [NetExport] extension to FireBug, it's the one I've found mentioned more often (and the one I tend to use):

* Tool Link: <http://www.softwareishard.com/har/viewer>
* Blog/Doc about the tool: <http://www.softwareishard.com/blog/har-viewer>
* Offline HAR Viewer: <http://code.google.com/p/harviewer/>

### Other tools
* [Chrome HAR Viewer](http://ericduran.github.io/chromeHAR/)
* Fiddler 2 - see instructions here: <http://alertfox.com/using-fiddler2-instead-of-the-online-har-viewer/>, more detail on Fiddler import/export options in this [MSDN Blog Post](http://blogs.msdn.com/b/fiddler/archive/2010/06/30/import-and-export-http-archives-from-fiddler.aspx)
* [PCAP Web Performance Analyzer](http://pcapperf.appspot.com/)
* [Charles Proxy](http://www.charlesproxy.com/documentation/version-history/)
* [HTTPWatch](http://blog.httpwatch.com/2009/10/19/httpwatch-version-62-supports-data-exchange-with-firebug/)
