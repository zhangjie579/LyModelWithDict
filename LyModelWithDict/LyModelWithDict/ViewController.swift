//
//  ViewController.swift
//  LyModelWithDict
//
//  Created by 张杰 on 2017/3/30.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        useRuntime()
    }


}

extension ViewController {
    
    fileprivate func useKVC() {
        let dict = ["name" : "kk" , "age" : 10 , "friend" : ["name" : "yy" , "girl" : "lyh"]  , "room" : [["size" : 8 , "bag" : "hello"] , ["size" : 6 , "bag" : "ko"]] , "image" : ["a" , "b" , "c"]] as [String : Any]

        let p = Person(dict: dict)
        let image = p.image
        let friendName = p.fr?.name
    }
}

extension ViewController {
    
    fileprivate func useRuntime() {
        let dict = ["oneA" : "aa" , "oneB" : 12 , "twoModel" : ["twoA" : "bb" , "twoB" : 3] , "threeModel" : [["threeA" : "cc" , "threeB" : [5 , 7]] , ["threeA" : "dd" , "threeB" : [3 , 6,  8]]] , "oneC" : ["1"] , "fourModel" : ["user" : "jack" , "number" : 123456]] as [String : Any];
        
        let p = OneModel.modelWithDict(dict: dict) as? OneModel
        
        print(p?.threeModel?[0].threeB?[0])
    }
}

