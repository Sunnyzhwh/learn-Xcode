//
//  Network.swift
//  Alamotest
//
//  Created by Sunny on 2019/10/7.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case get
    case post
}
class Network {
    class func requestData(url: String, type: MethodType, parameters: [String : Any]? = nil, finishedCallBack: @escaping (_ result: Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error ?? "---")
                return }
            finishedCallBack(result)
        }
    }
}
