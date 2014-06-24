//
//  ViewController.swift
//  PhilJSONDemo
//
//  Created by Ian on 18/06/2014.
//  Copyright (c) 2014 Ian. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //var searchManager:SearchManager?
    
    @IBOutlet var custIDField: UITextField
    
    
    @IBOutlet var errorTitleLabel: UILabel
    @IBOutlet var descriptionLabel: UILabel
    @IBOutlet var amountLabel: UILabel
    
    @IBOutlet var errorView: UIView
    @IBOutlet var errorText: UITextView
    @IBOutlet var resultView: UIView
    @IBOutlet var custNameField: UITextField
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        resultView.hidden=true
        errorView.hidden=true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchPressed(sender: AnyObject)
    {
        view.endEditing(true)
        
        resultView.hidden=true
        errorView.hidden=true
        
        var searchManager=SearchManager(initViewController: self)
        
        searchManager.search(custIDField.text)
    }
    
    
    @IBAction func updateButtonPressed(sender: AnyObject)
    {
        view.endEditing(true)
        
        resultView.hidden=true
        errorView.hidden=true
        
        var updateManager=UpdateManager(initViewController:self)
        
        updateManager.update(custIDField.text, custName: custNameField.text, desc: descriptionLabel.text, amt: amountLabel.text)
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!)
    {
        view.endEditing(true)
    }
    
    
    
    func setSearchResult(jsonResult:NSDictionary)
    {
        resultView.hidden=false;
        
        var cust=jsonResult["customer"] as NSDictionary
        
        var custName : AnyObject!=cust["customerName"]
        
        if custName is String
        {
            custNameField.text=custName as String
        }
        else
        {
            custNameField.text="[]"
        }
        
        var lastOrderNum : AnyObject!=cust["lastOrderNumber"]
        
        if lastOrderNum is String
        {
            descriptionLabel.text=lastOrderNum as String
        }
        else
        {
            descriptionLabel.text="[]"
        }
        
        var lastOrderAmt: AnyObject!=cust["lastOrderAmt"]
        
        if lastOrderAmt is String
        {
            amountLabel.text=lastOrderAmt as String
        }
        else
        {
            amountLabel.text="[]"
        }
        
    }
    
    
    
    
    func showErrorText(text:String,title:String="Error")
    {
        errorTitleLabel.text=title
        errorView.hidden=false
        errorText.text=text
    }
    
    
    
    
    
}

