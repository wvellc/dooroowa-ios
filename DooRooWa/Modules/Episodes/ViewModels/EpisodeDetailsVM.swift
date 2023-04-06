//
//  EpisodeDetailsVM.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/3/23.
//

import UIKit
import AVFoundation
import Combine

final class EpisodeDetailsVM: NSObject {
    
    //MARK: - Variables
    
    var objWeek = CurrentValueSubject<WeekModel?, Never>(nil)
    var objEpisode = CurrentValueSubject<EpisodeModel?, Never>(nil)
    
    var updateSeekbar = CurrentValueSubject<Float, Never>(0)
    var showBuffering = CurrentValueSubject<Bool, Never>(false)
    var audioPlayingStatus = CurrentValueSubject<Bool, Never>(false)
    var setupSeekbar = CurrentValueSubject<(start: Float, current: Float, total: Float), Never>((start: 0, current: 0, total: 1))
    
    private var dragingSlider = false
    private var player: AVPlayer?
    private var timeObserver: Any?
    
    init(week: WeekModel?, episode: EpisodeModel?) {
        /* Initial setup when view load */
        super.init()
        
        objWeek.send(week)
        objEpisode.send(episode)
        doInitialSettings()
    }
    
    deinit {
        stopAudioPlayer()
        print("Episodes Deatils View Model released from memory")
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        addObserver()
    }
    
    func didStartDragingSlider() {
        dragingSlider = true
    }
    
    func didStopDraging(value: Float) {
        let seconds : Int64 = Int64(value)
        let targetTime:CMTime = CMTime(value: seconds, timescale: 1)
        player?.seek(to: targetTime, completionHandler: { (isComplited) in
            if isComplited {
                self.dragingSlider = false
            }
        })
    }
    
    func playPauseAudio() {
        if player?.isPlaying ?? false {
            pauseAudio()
        } else {
            playAudio()
        }
    }
    
    func setAudio() {
        self.player?.pause()
        self.player = nil
        
        guard let url = URL(string: "https://file-examples.com/storage/fe9278ad7f642dbd39ac5c9/2017/11/file_example_MP3_2MG.mp3") else { return }
        let playerItem:AVPlayerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
        
        let duration : CMTime = player?.currentItem?.asset.duration ?? CMTime.zero
        let totalSeconds =  Float(CMTimeGetSeconds(duration))
        setupSeekbar.send((start: 0, current: 0, total: totalSeconds))
        
        //          self.lblTotalTime.text = "\(self.getFormatedTime(FromTime: Int(totalSeconds)))"
        if player?.isPlaying ?? false {
            let seconds =  Float(CMTimeGetSeconds(player?.currentTime() ?? CMTime.zero))
            updateSeekbar.send(seconds)
        } else {
            let seconds =  Float(CMTimeGetSeconds(player?.currentTime() ?? CMTime.zero))
            updateSeekbar.send(seconds)
            //             self.lblCurrentTime.text = self.getFormatedTime(FromTime: Int(seconds))
        }
    }
    
    func preriodicTimeObsever() {
        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 600), queue: DispatchQueue.main, using: { [weak self] time in
            let seconds =  Float(CMTimeGetSeconds(self?.player?.currentTime() ?? CMTime.zero))
            if !(self?.dragingSlider ?? false) {
                self?.updateSeekbar.send(seconds)
            }
            //             self.lblCurrentTime.text = self.getFormatedTime(FromTime: Int(seconds))
            
            if self?.player?.currentItem?.status == AVPlayerItem.Status.readyToPlay {
                if let isPlaybackLikelyToKeepUp = self?.player?.currentItem?.isPlaybackLikelyToKeepUp {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = !isPlaybackLikelyToKeepUp
                    self?.showBuffering.send(!isPlaybackLikelyToKeepUp)
                    self?.audioPlayingStatus.send(self?.player?.isPlaying ?? false)
                }
            }
        })
    }
    
    func playAudio() {
        preriodicTimeObsever()
        player?.play()
        audioPlayingStatus.send(true)
        showBuffering.send(true)
    }
    
    func pauseAudio() {
        player?.pause()
        audioPlayingStatus.send(false)
        showBuffering.send(false)
    }
    
    @objc func finishPlaying() {
        player?.seek(to: .zero)
        pauseAudio()
        updateSeekbar.send(0)
    }
    
    @objc func applicationDidEnterForeground() {
        if (player?.isPlaying ?? false) {
            showBuffering.send(true)
            audioPlayingStatus.send(true)
        } else {
            audioPlayingStatus.send(false)
        }
        preriodicTimeObsever()
    }
    
    func stopAudioPlayer() {
        player?.pause()
        timeObserver = nil
        player = nil
        
        removeObserver()
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(finishPlaying),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        preriodicTimeObsever()
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
}
extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
