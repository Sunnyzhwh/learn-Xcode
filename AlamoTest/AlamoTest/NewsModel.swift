//
//  NewsModel.swift
//  Alamotest
//
//  Created by Sunny on 2019/10/7.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
class NewsModel: NSObject {
    @objc var replyCount: Int = 0
    @objc var title: String = ""
    @objc var source: String = ""
    @objc var imgsrc: String = ""
    @objc var url: String = ""
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
