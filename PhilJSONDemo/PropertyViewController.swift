//
//  PropertyViewController.swift
//  PhilJSONDemo
//
//  Created by Ian on 21/06/2014.
//  Copyright (c) 2014 Ian. All rights reserved.
//

import UIKit

class PropertyViewController: UIViewController, UINavigationBarDelegate
{
    
    @IBOutlet var urlField: UITextField
    @IBOutlet var searchField: UITextField
    @IBOutlet var updateField: UITextField
    
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var app=UIApplication.sharedApplication().delegate as AppDelegate
        
        urlField.text=app.serviceURL
        searchField.text=app.searchCommand
        updateField.text=app.updateCommand

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?)
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        var app=UIApplication.sharedApplication().delegate as AppDelegate

        app.serviceURL=urlField.text
        app.searchCommand=searchField.text
        app.updateCommand=updateField.text
    }
    
}
