//
//  VisitWebsite.swift
//  Be_Helpful_App
//
//  Created by Michael Merani on 7/28/16.
//  Copyright © 2016 Michael Merani. All rights reserved.
//

import UIKit

class VisitWebsite: UIViewController {

    @IBOutlet weak var WebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "http://behelpful.byethost7.com/login.php")
        let request = NSURLRequest(URL: url!)
        WebView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
