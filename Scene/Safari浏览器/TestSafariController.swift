//
//  TestSafariController.swift
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/6/16.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

import UIKit
import SafariServices

class TestSafariController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let safariBtn = UIButton(frame: CGRect(x: 20, y: 100, width: self.view.frame.width - 40, height: 50))
        safariBtn.setTitle("SFSafariViewController获取ipa下载链接", for: .normal)
        safariBtn.backgroundColor = UIColor.gray
        safariBtn.addTarget(self, action: #selector(gotoSafariBrower), for: .touchUpInside)
        self.view.addSubview(safariBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotoSafariBrower() {
        let urlString = "https://www.pgyer.com/iAHq"
        
        if #available(iOS 9.0, *) {
            let safari = SFSafariViewController(url: URL.init(string: urlString)!)
            self.present(safari, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }

}
