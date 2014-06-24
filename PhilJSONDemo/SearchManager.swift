//
//  SearchManager.swift
//  PhilJSONDemo
//
//  Created by Ian on 21/06/2014.
//  Copyright (c) 2014 Ian. All rights reserved.
//

import Foundation
import UIKit

class SearchManager : NSObject, NSURLConnectionDelegate
{
    @lazy var data = NSMutableData()
    var viewController:ViewController
    
    init(initViewController:ViewController)
    {
        viewController=initViewController;
    }
    
    
    func search(custID:String)
    {
        data.length=0
        
        var app=UIApplication.sharedApplication().delegate as AppDelegate
        
        var urlPath=app.serviceURL+app.searchCommand+custID
        
        var url: NSURL = NSURL(string: urlPath)
        var request = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!)
    {
        self.data.appendData(data)
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!)
    {
        viewController.showErrorText(error.description)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!)
    {
        var dataString=NSString(data: data, encoding: NSUTF8StringEncoding)
        var err: NSError?
        
        var jsonObject : AnyObject!=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err)
        
        
        
        if err
        {
            viewController.showErrorText("Searched for:\(connection.originalRequest.URL.path)\n\(err.description):\n\(dataString)")
        }
        else
        {
            var jsonResult: NSDictionary = jsonObject as NSDictionary
            viewController.setSearchResult(jsonResult)
        }
    }
}
