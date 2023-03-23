//
//  IntroVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/22/23.
//

import UIKit
import AVKit


protocol IntroTutorialProtocol {
    func tutorialSkipped()
}
class IntroVC: UIViewController {
    
    static func instance() -> IntroVC {
        return IntroVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.home)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewVideo: UIView!
    
    //MARK: - Variables
    
    var introTutorialProtocol: IntroTutorialProtocol?
    
    private let playerViewController = AVPlayerViewController()
    private var videoUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        print("Intro screen released from memory")
    }
    
    //MARK: - IBActions
    
    @IBAction func btnSkipPressed(_ sender: UIButton) {
        introTutorialProtocol?.tutorialSkipped()
        self.dismiss(animated: true)
    }
    
    @IBAction func btnWatchVideoPressed(_ sender: UIButton) {
        playerViewController.player?.play()
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let videoURL = URL(string: self.videoUrl) {
                self.viewVideo.layoutIfNeeded()
                let player = AVPlayer(url: videoURL)
                self.playerViewController.player = player
                self.playerViewController.delegate = self
                self.addChild(self.playerViewController)
                self.viewVideo.addSubview(self.playerViewController.view)
                self.playerViewController.view.frame = self.viewVideo.frame
                self.playerViewController.view.frame.origin = .zero
                self.playerViewController.videoGravity = .resizeAspectFill
                self.playerViewController.player?.play()
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
extension IntroVC: AVPlayerViewControllerDelegate {
    
    func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print("willEndFullScreenPresentationWithAnimationCoordinator")
    }
}
