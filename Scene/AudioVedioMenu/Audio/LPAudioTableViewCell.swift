//
//  LPAudioTableViewCell.swift
//  CAAdvancedTech
//
//  Created by pingjun lin on 2017/6/22.
//  Copyright © 2017年 pingjun lin. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AudioToolbox

class LPAudioTableViewCell: UITableViewCell {
    
    enum LPMusicType {
        case AVPlayer
        case SystemSound
        case AVFoundation
        case MPMusicPlayerController
    }
    
    private var _musicType: LPMusicType = .AVPlayer
    public var musicType: LPMusicType {
        set {
            _musicType = newValue
            
            setupMusicContent(by: _musicType)
        }
        get {
            return _musicType
        }
    }
    
    private var avPlayer: AVPlayer?
    private var avFoundationPlayer: AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var musicBgImageView: UIImageView!
    @IBOutlet weak var playerBtn: UIButton!
    @IBOutlet weak var playFoundationLabel: UILabel!
    @IBOutlet weak var playSlider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playSlider.value = 0.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupMusicContent(by musicType: LPMusicType) {
        switch _musicType {
        case .AVPlayer:
            playFoundationLabel.text = "AVPlayer"
        case .AVFoundation:
            playFoundationLabel.text = "AVAudioPlayer"
        case .SystemSound:
            playFoundationLabel.text = "SystemSound"
        case .MPMusicPlayerController:
            playFoundationLabel.text = "MPMusicPlayerController"
        }
    }
    
    @IBAction func controlPlayValume(_ sender: Any) {
        switch _musicType {
        case .AVPlayer:
            print("AVPlayer Move")
        case .AVFoundation:
            let slider = sender as! UISlider
            avFoundationPlayer.volume = slider.value
        case .SystemSound:
            print("System Sound Move")
        case .MPMusicPlayerController:
            print("MPMusicPlayer Move")
        }
    }
    
    
    @IBAction func playMusicAction(_ sender: Any) {
        switch _musicType {
        case .AVPlayer:
            if #available(iOS 10.0, *) {
                playMusicByAVPlayer()
            } else {
                // Fallback on earlier versions
            }
        case .SystemSound:
            playMusicBySystemSoundService()
        case .AVFoundation:
            playMusicByAVFoundation()
        case .MPMusicPlayerController:
            playMusicByMPMusicPlayerController()
        }
    }

    
    // MARK: - AVPlayer
    
    @available(iOS 10.0, *)
    func playMusicByAVPlayer() {
        
        if let player = avPlayer {
            if player.timeControlStatus == .playing {
                player.pause()
                playerBtn.setTitle("播放", for: .normal)
            } else if player.status == .readyToPlay {
                player.play()
                playerBtn.setTitle("暂停", for: .normal)
            }
            
            return
        }
        
        if let musicUrl = URL(string: "http://116.224.86.28/m10.music.126.net/20170622190554/e326c51477f2de6ecb02bfbeea6071f1/ymusic/5368/a4f3/5c8c/b30d4441f82ee00b1bd2a06a690725e2.mp3?wshc_tag=0&wsts_tag=594b9ebb&wsid_tag=76f212c7&wsiphost=ipdbm") {
    
            let playItem = AVPlayerItem(url: musicUrl)
            avPlayer = AVPlayer.init(playerItem: playItem)
            
//            avPlayer = AVPlayer.init(url: musicUrl)
            
            if let player = avPlayer {
                player.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)
                player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let player = avPlayer else {
            return
        }
        
        if keyPath == "status" {
            if player.status == .readyToPlay {
                player.play()
    
                player.removeObserver(self, forKeyPath: "status")
            }
        }
        else if keyPath == "timeControlStatus" {
            
            if #available(iOS 10.0, *) {
                if player.timeControlStatus == .playing {
                    playerBtn.setTitle("暂停", for: .normal)
                }
                else if player.timeControlStatus == .paused {
                    playerBtn.setTitle("播放", for: .normal)
                }
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    
    // MARK: - System Sound Services
    
    func playMusicBySystemSoundService() {
        
        var soundId: SystemSoundID = 1
        
        // 获取音频本地路径
        if let fileUrl = Bundle.main.url(forResource: "kakao", withExtension: "caf") {
            // 注册音频文件，返回音频id-soundId
            AudioServicesCreateSystemSoundID(fileUrl as CFURL, &soundId)
            
            // 播放
            AudioServicesPlaySystemSound(soundId)
            // 震动播放
            //AudioServicesPlayAlertSound(soundId)
            
            // 注册音频播放完成的回调-Swift3使用Closure,OC使用注册函数
            AudioServicesAddSystemSoundCompletion(soundId, nil, nil, { (soundId, clientData) in
                AudioServicesDisposeSystemSoundID(soundId)
            }, nil)
        }
    }

    // MARK: - AVFoundation
    
    // play music
    func playMusicByAVFoundation() {
        
        if avFoundationPlayer.isPlaying {
            avFoundationPlayer.pause()
            playerBtn.setTitle("播放", for: .normal)
        } else {
            // 播放本地音乐
            guard let musicUrl = Bundle.main.url(forResource: "happy_ending", withExtension: "mp3") else {
                return
            }
            do {
                avFoundationPlayer = try AVAudioPlayer(contentsOf: musicUrl)
                avFoundationPlayer.play()
                playerBtn.setTitle("暂停", for: .normal)
            }
            catch {
                print("AVAudioFoundation Player Error!")
            }
        }
    }
    // record
    func recordMusicByAVFoundation() {
        
    }
    
    // MARK: - MPMusicPlayerController
    
    func playMusicByMPMusicPlayerController() {
        //        let musicPlayer = MPMusicPlayerController.systemMusicPlayer()
        //
        //        if musicPlayer.indexOfNowPlayingItem == NSNotFound {
        //            musicPlayer.play()
        //        }
        
        let applicationMusicPlayer = MPMusicPlayerController.applicationMusicPlayer()
        if #available(iOS 9.3, *) {
            if MPMediaLibrary.authorizationStatus() != .authorized {
                MPMediaLibrary.requestAuthorization({ (status) in
                    print("status='\(status)'")
                })
            }
        } else {
            // Fallback on earlier versions
        }
        applicationMusicPlayer.setQueue(with: MPMediaQuery.songs())
        applicationMusicPlayer.play()
    }
    
    deinit {
        avPlayer?.removeObserver(self, forKeyPath: "timeControlStatus")
    }
}
