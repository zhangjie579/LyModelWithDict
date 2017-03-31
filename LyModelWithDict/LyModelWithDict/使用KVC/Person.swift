//
//  Person.swift
//  001
//
//  Created by 张杰 on 2017/3/29.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class Person: NSObject {

    //1.要设置为可选类型，要不就设置初始值
    var fr : Friend?
    var rm : [Room]?
    
    var name : String?
    var age  : Int = 0
    //字典
    var friend : [String : Any]? {
        didSet {
            fr = Friend(dict : friend!)
        }
    }
    //model数组
    var room : [[String : Any]]? {
        didSet {
            var array = [Room]()
            for value in room! {
//                let k = Room(dict: value)
//                array.append(k)
            }
            rm = array
        }
    }
    var image : [String]?
    
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

    
}

