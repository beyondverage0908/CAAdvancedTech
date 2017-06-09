//
//  PlistManager.swift
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/3/30.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

import UIKit

class PlistManager {
    static let defaultManager: PlistManager = PlistManager()
    
    private let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    
    func loadData() {
        let path = documentDirectory.appending("/GlobalConfigList.plist")
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: path) {
            if let bundlePath = Bundle.main.path(forResource: "GlobalConfigList", ofType: "plist") {
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("bundlePath -->> \(result!)")
                
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                } catch {
                    print("copy failure")
                }
            } else {
                print("GlobalConfigList.plist not found")
            }
        } else {
            print("GlobalConfigList.plist already exists at path")
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("-->> load GlobalConfigList.plist is \(resultDictionary!)) at path -->> \(path)")
    }
    
    func getValue(key: String = "") -> Any? {
        let bundlePath = Bundle.main.path(forResource: "GlobalConfigList", ofType: "plist")!
        
        let plist = NSDictionary(contentsOfFile: bundlePath)
    
        guard key != "" else {
            return plist as Any?
        }
        
        return plist![key] as Any?
    }
    
    func write(value: Any!, key: String) {
        let bundlePath = Bundle.main.path(forResource: "GlobalConfigList", ofType: "plist")!
        
        let plist = NSMutableDictionary(contentsOfFile: bundlePath)!
        
        plist.setValue(value, forKey: key)
        plist.write(toFile: bundlePath, atomically: true)
        
    }
}
