//
//  ElevatorControlCenterController.swift
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/2/18.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

import UIKit

// 规则
// 1. 第一次使用默认是 firstElevator = 1 secondElevator = 1
// 2. 距离楼层更近的先启动
// 3. 同楼层的顺序由左往右

class ElevatorControlCenterController: UIViewController {

    static let elevatorCount = 2
    
    @IBOutlet weak var firstElevator: UITextField!
    @IBOutlet weak var secondElevator: UITextField!
    @IBOutlet weak var gotoElevatorTextField: UITextField!
    
    static var elevatorRecordList: Array<Int> = Array.init(repeating: 1, count: elevatorCount)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstElevator.text = String(ElevatorControlCenterController.elevatorRecordList[0])
        secondElevator.text = String(ElevatorControlCenterController.elevatorRecordList[1])
    }
    
    @IBAction func go(_ sender: UIButton) {
        let floor: Int = Int(gotoElevatorTextField.text!)!
        self.elevatorControlCenter(goFloor: floor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func elevatorControlCenter(goFloor floor: Int) {
        let firstFloor = Int(firstElevator.text!)!
        let secondFloor = Int(secondElevator.text!)!
        
        if abs(floor - firstFloor) < abs(floor - secondFloor) {
            firstElevator.text = String(floor)
            ElevatorControlCenterController.elevatorRecordList[0] = floor
        }
        else if abs(floor - firstFloor) > abs(floor - secondFloor) {
            secondElevator.text = String(floor)
            ElevatorControlCenterController.elevatorRecordList[1] = floor
        }
        else {
            firstElevator.text = String(floor)
            ElevatorControlCenterController.elevatorRecordList[0] = floor
        }
    }

}
