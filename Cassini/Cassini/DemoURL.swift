//
//  DemoURL.swift
//  Cassini
//
//  Created by Sunny on 2019/7/10.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import Foundation

struct DemoURL {
    static let stanford = Bundle.main.url(forResource: "oval", withExtension: "jpg")
    
    static var NASA: Dictionary<String,URL> = {
        let NASAURLStrings = [
            "Cassini" : "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562779572484&di=f1621ef3298065591e9f935956ee2f12&imgtype=0&src=http%3A%2F%2Fs1.1zoom.me%2Fbig3%2F543%2FSaturn_planet_Satellite_Planetary_ring_Cassini_532437_5200x3250.jpg",
            "Earth" : "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1563374362&di=9b26688ee17986783b035d311142bc37&imgtype=jpg&er=1&src=http%3A%2F%2Fimg.25pp.com%2Fuploadfile%2Fapp%2Ficon%2F20160627%2F1466963235579022.jpg",
            "Saturn" : "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562779673012&di=385879f9271152f309f4d20e4c5de665&imgtype=0&src=http%3A%2F%2Fblog.open365.cn%2Fcontent%2Fimages%2F2016%2F02%2FSaturn.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
        
    }()
}
