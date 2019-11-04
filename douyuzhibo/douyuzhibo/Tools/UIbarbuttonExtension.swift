//
//  UIbarbuttonExtension.swift
//  douyuzhibo
//
//  Created by Sunny on 2019/9/30.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
    /*
    class func creatUIbarButtonItem(normalImage named: String, highlightedImage hinamed: String , size: CGSize) -> UIBarButtonItem {
        let  btn = UIButton()
        btn.setImage(UIImage(named: named), for: .normal)
        btn.setImage(UIImage(named: hinamed), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
     */
    //MARK: convenience init 必须调用一个设计构造函数（self）
    convenience init(normalImage named: String, highlightedImage hinamed: String = "" , size: CGSize = CGSize.zero) {
        let  btn = UIButton()
        btn.setImage(UIImage(named: named), for: .normal)
        if hinamed != ""{
        btn.setImage(UIImage(named: hinamed), for: .highlighted)
        }
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}

