//
//  myNavigationController.swift
//  Alamotest
//
//  Created by Sunny on 2019/10/8.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

class myNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBar.tintColor = UIColor.white
    }
}
