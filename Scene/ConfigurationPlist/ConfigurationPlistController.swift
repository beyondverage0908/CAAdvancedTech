//
//  ConfigurationPlistController.swift
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/3/28.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

import UIKit

class ConfigurationPlistController: SwiftBaseViewController {

    static let cell_reuse_identifier = "cell_reuse_identifier"
    
    fileprivate let tableView = UITableView()
    private let refreshBtn = UIButton()
    private let appendBtn = UIButton()
    private let printBtn = UIButton()
    
    fileprivate var globalConfig = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        tableView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH - TABBARH)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ConfigurationPlistController.cell_reuse_identifier)
        self.view.addSubview(tableView)
        
        let footerView = UIView(frame: CGRect(x: 0, y: tableView.frame.maxY, width: SCREENW, height: TABBARH))
        footerView.backgroundColor = .white
        self.view.addSubview(footerView)
        
        let btnWidth = footerView.frame.width / 3.0
        
        refreshBtn.frame = CGRect(x: 0, y: 0, width: btnWidth, height: footerView.frame.height)
        refreshBtn.backgroundColor = .cyan
        refreshBtn.setTitle("刷新", for: .normal)
        refreshBtn.addTarget(self, action: #selector(handleRefreshUI(sender:)), for: .touchUpInside)
        footerView.addSubview(refreshBtn)
        
        appendBtn.frame = CGRect(x: refreshBtn.frame.maxX, y: 0, width: btnWidth, height: footerView.frame.height)
        appendBtn.backgroundColor = .yellow
        appendBtn.setTitle("追加", for: .normal)
        appendBtn.addTarget(self, action: #selector(handleAppendPlist(sender:)), for: .touchUpInside)
        footerView.addSubview(appendBtn)
        
        printBtn.frame = CGRect(x: appendBtn.frame.maxX, y: 0, width: btnWidth, height: footerView.frame.height)
        printBtn.backgroundColor = .red
        printBtn.setTitle("测试", for: .normal)
        printBtn.addTarget(self, action: #selector(handleRemovePlist(sender:)), for: .touchUpInside)
        footerView.addSubview(printBtn)
        
        PlistManager.defaultManager.loadData()
        
        operation()
    }
    
    func handleRefreshUI(sender: UIButton) {
        print("-->>handleRefreshUI")
    }
    
    func handleAppendPlist(sender: UIButton) {
        print("-->>handleAppendPlist")
    }
    
    func handleRemovePlist(sender: UIButton) {
        print("-->>handleAppendPlist")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 方法体
    
    func operation() {
        guard let plist = PlistManager.defaultManager.getValue() as? NSDictionary else {
            return
        }
        
        print(plist["student"]!)
        
        let student = plist["student"] as! NSDictionary
        print(student["age"]!)
        
        print("-------------------------------")
        
        PlistManager.defaultManager.write(value: "macbook", key: "mac")
        
        print("-------------------------------")
        
        print(PlistManager.defaultManager.getValue()!)
    }
    
    func getGlobalConfig() {
        let path = Bundle.main.path(forResource: "GlobalConfigList", ofType: "plist")
        globalConfig = NSDictionary.init(contentsOfFile: path!)!
        
        print(globalConfig)
    }
    
    func setGlobalConfig() -> Void {
        let jsonStringDic = "{\"barItemList\":[{\"toptitle\":\"首页\",\"foottitle\":\"首页\",\"topImageUrl\":\"wwww.baidu.com.jpg\"},{\"toptitle\":\"企业活动\",\"foottitle\":\"活动\",\"topImageUrl\":\"\"},{\"toptitle\":\"商城\",\"foottitle\":\"福利\",\"topImageUrl\":\"\"},{\"toptitle\":\"发现\",\"foottitle\":\"动态\",\"topImageUrl\":\"\"},{\"toptitle\":\"我\",\"foottitle\":\"我的\",\"topImageUrl\":\"\"}]}"
        
        let jsonStringArr = "[{\"title\":\"Swift\"},{\"title\":\"Objective-C\"},{\"title\":\"Java\"}]"
        
        print("--->>>\(jsonStringDic.convertToDictionary())")
        
        print("--->>>\(jsonStringArr.convertToArray())")
        
        
        let path = Bundle.main.path(forResource: "GlobalConfigList", ofType: "plist")
        let readDict = NSMutableDictionary.init(contentsOfFile: path!)
        
        readDict?.setObject(jsonStringDic.convertToDictionary(), forKey: "navgation" as NSCopying)
        readDict?.setObject(jsonStringArr.convertToArray(), forKey: "language" as NSCopying)
    }
}

extension ConfigurationPlistController: UITableViewDelegate {
    
}

extension ConfigurationPlistController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return globalConfig.allKeys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = globalConfig.allKeys[section] as! String
        let value = globalConfig.value(forKey: key) as! NSDictionary
        
        return value.allKeys.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ConfigurationPlistController.cell_reuse_identifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: ConfigurationPlistController.cell_reuse_identifier)
        }
        
        let secondKey = globalConfig.allKeys[indexPath.section] as! String
        let value = globalConfig.value(forKey: secondKey) as! NSDictionary
        
        let key = value.allKeys[indexPath.row] as? String
        
        if value.object(forKey: key!) != nil {
            cell?.textLabel?.text = String(describing: value.object(forKey: key!)!)
        }
        
        return cell!
    }
}
