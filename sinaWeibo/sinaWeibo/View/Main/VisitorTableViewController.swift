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
        visitorView?.delegate = self
        view = visitorView
        
    }

}
extension VisitorTableViewController: VisitorViewDelegate {
    func visitorDidReg() {
        print("注册")
    }
    
    func visitorDidLogin() {
        print("登录")
    }
    
    
}
