//
//  MyViewController.swift
//  learn Xcode
//
//  Created by Sunny on 2019/6/10.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
import WebKit

class MyViewController: UIViewController {

    @IBOutlet weak var Go: UIButton! = nil
    @IBOutlet weak var Urlww: UITextField! = nil
    @IBOutlet weak var WV: WKWebView! = nil
    @IBAction func Gobtnclicked(sender:AnyObject){
        let myUrl = URL(string: Urlww.text!)
        
        let myUR = URLRequest(url: myUrl!)
        
        WV.load(myUR)
        
        Urlww.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
