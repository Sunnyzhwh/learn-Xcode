//
//  WebDetailViewController.swift
//  Alamotest
//
//  Created by Sunny on 2019/10/9.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
import WebKit
class WebDetailViewController: UIViewController, WKUIDelegate {
    var weburl: String = ""
    var newsD: NewsModel?{
        didSet{
            self.weburl = (newsD?.url ?? "http://m.163.com")
        }
    }
    
    var wkwv = WKWebView()
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        wkwv = WKWebView(frame: .zero, configuration: webConfiguration)
        wkwv.uiDelegate = self
        view = wkwv
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(weburl)
        guard let myURL = URL(string: weburl) else { return }
        let webR = URLRequest(url: myURL)
        wkwv.load(webR)
    }

}
