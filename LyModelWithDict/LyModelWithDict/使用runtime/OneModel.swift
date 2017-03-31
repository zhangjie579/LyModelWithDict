//
//  OneModel.swift
//  LyModelWithDict
//
//  Created by 张杰 on 2017/3/30.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class OneModel: NSObject {

    var oneA : String?
    var oneB : Int = 0
    var oneC : [String]?
    
    var twoModel : TwoModel?
    
    var threeModel : [ThreeModel]?
    
    var fourModel : FourModel?
}

extension OneModel : BaseModelDelegate {
    func arrayContainModelClass() -> ([String : Any]) {
        return ["threeModel" : "ThreeModel"]
    }
    
    func dictContainModelClass() -> ([String : Any]) {
        return ["twoModel" : "TwoModel" , "fourModel" : "FourModel"]
    }
    
}
