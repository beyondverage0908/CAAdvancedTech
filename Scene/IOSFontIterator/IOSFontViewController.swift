//
//  IOSFontViewController.swift
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/2/23.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

import UIKit

class IOSFontViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        var fontNames = [String]()
        
        for familyName in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                fontNames.append(fontName)
            }
        }
        
        let screenW = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height
        let fontLabelH = 50
        
        let fontScrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH))
        fontScrollView.contentSize = CGSize(width: Double(screenW), height: Double(fontNames.count * fontLabelH))
        self.view.addSubview(fontScrollView)
        
        for font in fontNames.enumerated() {
            let fontLabel = UILabel(frame: CGRect(x: 0, y: fontLabelH * font.offset, width: Int(screenW), height: fontLabelH))
            fontLabel.text = String.init(format: "19382 - %@", font.element)
            fontLabel.textAlignment = .center
            fontLabel.font = UIFont.init(name: font.element, size: 18)
            fontScrollView.addSubview(fontLabel)
            print(font.element)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
