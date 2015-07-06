//
//  RestApiManager.swift
//  Crumful-Mil
//
//  Created by Marvin Allan Lu on 7/1/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://fulcrum.sourcepad.com/api/v1"
    
    func getProject(id: Int, onCompletion: (JSON) -> Void) {
        let route = "\(baseURL)/projects/\(id)"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getProjects(onCompletion: (JSON) -> Void) {
        let route = "\(baseURL)/projects"
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data)
            onCompletion(json, error)
        })
        
        task.resume()
    }
}