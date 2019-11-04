//
//  VisitorTableViewController.swift
//  sinaWeibo
//
//  Created by Sunny on 2019/11/4.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

class VisitorTableViewController: UITableViewController {

    private var userLogon = false
    var visitorView: VisitorView?
    override func loadView() {
        print("visitor")
        userLogon ? super.loadView() : setupVisitorView()
    }
    private func setupVisitorView() {
        visitorView = VisitorView()
        
        view = visitorView
        visitorView?.registerButtion.addTarget(self, action: #selector(visitorDidReg), for: .touchUpInside)
        visitorView?.loginButtion.addTarget(self, action: #selector(visitorDidLogin), for: .touchUpInside)
    }

}
extension VisitorTableViewController {
    @objc func visitorDidReg() {
        print("注册")
    }
    
    @objc func visitorDidLogin() {
        print("登录")
    }
    
    
}
