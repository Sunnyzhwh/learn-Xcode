//
//  main.swift
//  protocol
//
//  Created by Sunny on 2019/6/10.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import Foundation

protocol people{
    func getName()->String
    
}
class man:people{
    func getName() -> String {
        return "zhangsanfeng"
    }
}
var m = man()
print("Name is \(m.getName())")

