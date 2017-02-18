//
//  FistSwiftViewController.swift
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/2/15.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

import UIKit

class FistSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let showLabel: UILabel = UILabel.init(frame: CGRect(x: 15, y: 100, width: self.view.frame.size.width - 30 , height: 50))
        showLabel.text = "FistSwiftViewController"
        showLabel.backgroundColor = UIColor.cyan
        showLabel.textAlignment = .center
        showLabel.textColor = UIColor.white
        self.view.addSubview(showLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
