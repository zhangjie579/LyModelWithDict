//
//  Friend.swift
//  001
//
//  Created by 张杰 on 2017/3/29.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class Friend: NSObject {

    var name : String?
    var girl : String?
    
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
