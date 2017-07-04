//
//  LPAudioViewController.swift
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/6/21.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

import UIKit

class LPAudioViewController: UIViewController {

    @IBOutlet weak var musicListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicListView.delegate = self
        musicListView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LPAudioViewController: UITableViewDelegate {

}

extension LPAudioViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LPAudioTableViewCell") as? LPAudioTableViewCell {
            
            switch indexPath.row {
            case 0:
                cell.musicType = .AVPlayer
            case 1:
                cell.musicType = .AVFoundation
            case 2:
                cell.musicType = .SystemSound
            case 3:
                cell.musicType = .MPMusicPlayerController
            default:
                cell.musicType = .AVPlayer
            }
            
            return cell
        }
        return UITableViewCell()
    }
}
