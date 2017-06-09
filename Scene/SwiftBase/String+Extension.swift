//
//  String+Extension.swift
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/3/28.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

import Foundation

extension String {
    
    func convertToDictionary() -> [String : Any] {
        var dict = [String : Any]()
        
        do {
            if let data = self.data(using: .utf8),
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] {
                dict = json
            }
        } catch {
            print("Error Description With Json \(error)")
        }
        return dict
    }
    
    func convertToArray() -> [Any] {
        var arr = [Any]()
        
        do {
            if let data = self.data(using: .utf8),
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any] {
                arr = json
            }
        } catch {
            print("Error Description With Json \(error)")
        }
        return arr
    }
}
