//
//  UpdateManager.swift
//  PhilJSONDemo
//
//  Created by Ian on 21/06/2014.
//  Copyright (c) 2014 Ian. All rights reserved.
//

import Foundation
import UIKit

class UpdateManager: NSObject , NSURLConnectionDelegate
{
    @lazy var data = NSMutableData()
    var viewController:ViewController
    
    init(initViewController:ViewController)
    {
        viewController=initViewController;
    }
    
    func update(custID:String,custName:String,desc:String,amt:String)
    {
        var app=UIApplication.sharedApplication().delegate as AppDelegate
        var cust=NSMutableDictionary()
                cust.setValue(custID, forKey: "customerID")
        cust.setValue(custName, forKey: "customerName")
        cust.setValue(desc, forKey: "lastOrderNumber")
        cust.setValue(amt, forKey: "lastOrderAmt")

        var custRoot=NSMutableDictionary()
        
        custRoot.setValue(cust, forKey: "customer")
        
        var custData=NSJSONSerialization.dataWithJSONObject(custRoot, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        var dataString=NSString(data: custData, encoding: NSUTF8StringEncoding)
        var urlPath=app.serviceURL+app.updateCommand
        
        //var urlPath="http://validate.jsontest.com/
        var url: NSURL = NSURL(string: urlPath)
        
        var request=NSMutableURLRequest(URL:url)
        request.HTTPMethod="POST"
        request.HTTPBody=dataString.dataUsingEncoding(NSUTF8StringEncoding)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.addValue("\(dataString.length)", forHTTPHeaderField: "Content-Length")
        request.addValue("gzip,deflate", forHTTPHeaderField: "Accept-Encoding")
        
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
        
        viewController.showErrorText(dataString,title: "Return")

        
        //println("Searched for:\(connection.originalRequest.URL.path)\nFinished loading:\(dataString)")
        
        
        /*
        var err: NSError?
        
        var jsonObject : AnyObject!=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err)
        
        if err
        {
            viewController.showErrorText("\(err.description):\n\(dataString)")
        }
        else
        {
            var jsonResult: NSDictionary = jsonObject as NSDictionary
            viewController.setSearchResult(jsonResult)
        }
*/
    }

}
