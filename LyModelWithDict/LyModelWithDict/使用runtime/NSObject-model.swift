//
//  NSObject-model.swift
//  LyRacDemo
//
//  Created by 张杰 on 2017/3/29.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

@objc protocol BaseModelDelegate : NSObjectProtocol {
    
    //非必须实现的协议
    
    /* 字典数组 dictArray
     String:后台返回的key
     Any   :需要转换成那个class
     例子 ： return ["room" : "Room"]
     */
    @objc optional func arrayContainModelClass() -> ([String : Any])
    
    /* 2.字典中包含字典
     String:后台返回的key
     Any   :需要转换成那个class
     例子 ： return ["student" : "Student" as Any]
     */
    @objc optional func dictContainModelClass() -> ([String : Any])
    
}

extension NSObject {
    
    class func modelWithDict(dict : [String : Any]) -> NSObject {
        
        let objc = self.init()
        //获得映射关系
//        let attributDic = attributesDic(dic: dict)
        
        //Runtime获取本类属性
        var count : UInt32 = 0
        let ivars = class_copyIvarList(objc.classForCoder, &count)
        
//        let propertyLists = class_copyPropertyList(objc.classForCoder, &count);
//        for i in 0..<Int(count) {
//            let propertyList = propertyLists?[i]
//            let name = String(cString: property_getName(propertyList))
//            let property = property_getAttributes(propertyList)
//            let k = String(cString: property!)
//            print("name=" + name + "-------" + "property=" + k)
//        }
        
        for i in 0..<count {
            
            //1.取出属性名
            let ivar = ivars?[Int(i)]
            let ivarName = ivar_getName(ivar)
            
            //2.属性名称
            let name = String(cString: ivarName!)
            
            //属性类型,不知道为什么swift中获取不到属性的类型，全为""
//            var type = String(cString: ivar_getTypeEncoding(ivar)!)
            
            //3.取出要赋值的值
            let key = name
//            if key == nil {
//                key = ""
//            }
            //值
            var value = dict[key]
            
            //获取工程名称
            let group = Bundle.main.infoDictionary
            let fileName = group?[kCFBundleExecutableKey as String] as! String
            
            //4.如果值是字典(二级转换)
            if ((value as? [String : Any]) != nil) {
                
                guard let obj = objc as? BaseModelDelegate else {
                    if value != nil {
                        objc.setValue(value!, forKey: key)
                    }
                    continue
                }
                guard let dictClass = obj.dictContainModelClass!()[key] else {
                    if value != nil {
                        objc.setValue(value!, forKey: key)
                    }
                    continue
                }
                let modelClass = NSClassFromString("\(fileName).\(dictClass as! String)") as? NSObject.Type
                if modelClass != nil {
                    value = modelClass?.modelWithDict(dict: value! as! [String : Any])
                }
            }
            
            //5.数组，（三级转换）
            if ((value as? [NSObject]) != nil) {
                //let idSelf = self
                
                //如果是数组，但是没有实现BaseModelDelegate，就直接使用kvc赋值，再进入下一次循环
                guard let obj = objc as? BaseModelDelegate else {
                    if value != nil {
                        objc.setValue(value!, forKey: key)
                    }
                    continue
                }
                
                guard let arrayClass = obj.arrayContainModelClass!()[key] else {
                    if value != nil {
                        objc.setValue(value!, forKey: key)
                    }
                    continue
                }
                
                let modelClass = NSClassFromString("\(fileName).\(arrayClass as! String)") as? NSObject.Type
                
                if modelClass != nil {
                    var array = [NSObject]()
                    for dic in value as! [[String : Any]] {
                        let model = modelClass?.modelWithDict(dict: dic)
                        array.append(model!)
                    }
                    value = array as Any?
                }
            }
            
            
            if value != nil {
                objc.setValue(value!, forKey: key)
            }
        }
        return objc
    }
    
//    //如果属性名与数据字典的key值不对应，那么在子类model中复写此方法，将属性名作为key，字典key值作为value
//    final class func attributesDic(dic : [String : Any]) -> [String : String] {
//        var newDic:[String:String] = [:]
//        for key in dic.keys {
//            //复写时注意将属性名作为key 数据字典的key作为value
//            newDic[key] = key
//        }
//        return newDic
//    }

}
