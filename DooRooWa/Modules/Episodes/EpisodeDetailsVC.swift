//
//  EpisodeDetailsVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/3/23.
//

import UIKit
import AVFoundation
import AVKit

class EpisodeDetailsVC: UIViewController {
    
    static func instance() -> EpisodeDetailsVC {
        return EpisodeDetailsVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.episodes)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imgViewBg: UIImageView!
    @IBOutlet weak var imgViewEpisode: UIImageView!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var slideerSeekbar: UISlider!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var viewVideo: UIView!
    @IBOutlet weak var activityBuffer: UIActivityIndicatorView!
    
    //MARK: - Variables
    
    var episodeDetailsVM: EpisodeDetailsVM?
    private var playerViewController: AVPlayerViewController?
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    deinit {
        episodeDetailsVM?.stopAudioPlayer()
//        episodeDetailsVM = nil
        print("Episode details screen released from memory")
    }
    
    //MARK: - IBActions
    
    @IBAction func btnPlayPausePressed(_ sender: UIButton) {
        episodeDetailsVM?.playPauseAudio()
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
//        slideerSeekbar.isContinuous = false
        slideerSeekbar.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        bindViewModel()
    }
    
    fileprivate func bindViewModel() {

        episodeDetailsVM?.objEpisode.bind({ [weak self] (episode) in
            self?.lblTitle.text = episode?.title ?? ""
            self?.lblDescription.text = episode?.description ?? ""
            self?.imgViewEpisode.image = (episode?.id ?? 0) % 2 == 0 ? #imageLiteral(resourceName: "svgWeek2") : #imageLiteral(resourceName: "svgWeek1")
            if (episode?.type) == "video".localized {
                self?.showVideo()
            } else {
                self?.episodeDetailsVM?.setAudio()
            }
        })
        
        bindAuidPlayer()
    }
    
    fileprivate func bindAuidPlayer() {
        episodeDetailsVM?.updateSeekbar.bind({ [weak self] (value) in
            self?.slideerSeekbar.value = value
        })
        
        episodeDetailsVM?.audioPlayingStatus.bind({ [weak self] (isPlaying) in
            if isPlaying {
                self?.btnPlayPause.setImage(#imageLiteral(resourceName: "svgPauseBig"), for: .normal)
            } else {
                self?.btnPlayPause.setImage(#imageLiteral(resourceName: "svgPlayBlue"), for: .normal)
            }
        })
        
        episodeDetailsVM?.showBuffering.bind({ [weak self] (isShow) in
            if isShow {
                self?.activityBuffer.startAnimating()
            } else {
                self?.activityBuffer.stopAnimating()
            }
        })
        
        episodeDetailsVM?.setupSeekbar.bind({ [weak self] (start: Float, current: Float, total: Float) in
            self?.slideerSeekbar.minimumValue = start
            self?.slideerSeekbar.value = current
            self?.slideerSeekbar.maximumValue = total
        })
    }
    
    fileprivate func showVideo() {
        self.viewVideo.isHidden = false
        playerViewController = AVPlayerViewController()
        if let playerViewController, let videoURL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") {
            self.viewVideo.layoutIfNeeded()
            let player = AVPlayer(url: videoURL)
            self.playerViewController?.player = player
            //            self.playerViewController.delegate = self
            self.addChild(playerViewController)
            self.viewVideo.addSubview(playerViewController.view)
            playerViewController.view.frame = self.viewVideo.frame
            playerViewController.view.frame.origin = .zero
            playerViewController.videoGravity = .resizeAspectFill
            playerViewController.player?.play()
        }
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                episodeDetailsVM?.didStartDragingSlider()
                // handle drag began
                break
            case .ended:
                // handle drag ended
                episodeDetailsVM?.didStopDraging(value: slider.value)
                break
            default:
                break
            }
        }
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

