//
//  demoURL.swift
//  view
//
//  Created by Sunny on 2019/9/27.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import Foundation
struct demoURL {
    static var superstar: Dictionary<String,URL> = {
        let URLStrings = [
            "yang" : "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569598863716&di=8ba63b2b11df5385938e0ac004754663&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201503%2F20%2F20150320220039_PBckv.jpeg",
            "zheng" : "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569604871129&di=88d471a9408a60b076dc063a5ff73b9f&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201607%2F16%2F20160716215608_fUA3Z.jpeg",
            "zhou" : "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569605096418&di=ac780721ebcbacd255b370458adf4349&imgtype=0&src=http%3A%2F%2Flvyoubolanhui.com%2Fuploads%2Fallimg%2F130703%2Fco130F30Q320-3.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for (key, value) in URLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
