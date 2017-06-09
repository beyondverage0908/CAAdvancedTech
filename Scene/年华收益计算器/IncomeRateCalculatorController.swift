//
//  IncomeRateCalculatorController.swift
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/6/9.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

import UIKit

class IncomeRateCalculatorController: UIViewController {

    @IBOutlet weak var benjinT: UITextField!
    @IBOutlet weak var lilvT: UITextField!
    @IBOutlet weak var tianshuT: UITextField!
    @IBOutlet weak var jineT: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func calculatMoney(_ sender: Any) {
        
        let benjin = Float(benjinT.text ?? "0")
        let lilv = Float(lilvT.text ?? "0") ?? 0 / 100
        let tianshu = Float(tianshuT.text ?? "0")
        
        if let bj = benjin, let ts = tianshu {
            let money = (bj * lilv * ts) / (365 * 100)
            jineT.text = "\(money)"
        } else {
            jineT.text = "0"
        }
    }
}
