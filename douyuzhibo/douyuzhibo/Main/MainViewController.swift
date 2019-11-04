//
//  MainViewController.swift
//  douyuzhibo
//
//  Created by Sunny on 2019/9/30.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(storyboardname: "home")
        addChildVC(storyboardname: "live")
        addChildVC(storyboardname: "follow")
        addChildVC(storyboardname: "profile")
        // Do any additional setup after loading the view.
    }
    
    private func addChildVC(storyboardname: String) {
        let vc = UIStoryboard(name: storyboardname, bundle: nil).instantiateInitialViewController()!
        addChild(vc)
    }

}
