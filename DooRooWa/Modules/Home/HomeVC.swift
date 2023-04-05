//
//  HomeVC.swift
//  DooRooWa
//
//  Created by Vision on 15/03/23.
//

import UIKit
import Ripples
import ViewAnimator
import SPPerspective
import AVFoundation
import AVKit

class HomeVC: UIViewController {
    
    static func instance() -> HomeVC {
       return HomeVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.home)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var stViewMain: UIStackView!
    @IBOutlet weak var lblWeek: UILabel!
    @IBOutlet weak var imgViewStartWeekLayers: UIImageView!
    @IBOutlet weak var viewStartWeekBubble: UIView!
    @IBOutlet weak var imgViewStartWeekMovingLayers: UIImageView!
    @IBOutlet weak var imgViewStartWeekRipples: UIImageView!
    
    @IBOutlet weak var imgViewGate: UIImageView!
    @IBOutlet weak var imgViewDooRooWa: UIImageView!
    
    @IBOutlet weak var imgViewWeeklyProgress: UIImageView!

    
    //MARK: - Variables
    
    private var arrImages = [#imageLiteral(resourceName: "svgGate1"), #imageLiteral(resourceName: "svgGate2"), #imageLiteral(resourceName: "svgGate3"), #imageLiteral(resourceName: "svgGate4"),]

    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = UserDefaults.shared.retriveCustomObject(.user) as? Data,
           let user = try? JSONDecoder().decode(UserModel.self, from: data),
           let name = user.name?.components(separatedBy: " ").first {
            title = "welcome".localized + "\(name)!"
        } else {
            title = "welcome".localized
        }
        restartStartWeekAnimation()
    }
    
    deinit {
        removeObservers()
        print("Home screen released from memory")
    }
    
    //MARK: - IBActions
    
    @IBAction func btnMenuPressed(_ sender: UIBarButtonItem) {
        if !imgViewGate.isAnimating {
            sideMenuController?.showLeftView()
        }
    }

    @IBAction func btnNotificationsPressed(_ sender: UIBarButtonItem) {
        let aVC = NotificationsVC.instance()
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    @IBAction func btnStartWeekPressed(_ sender: UIButton) {
        let aVC = EpisodesVC.instance()
        let aWeek = WeekModel(id: 1, week: "\("week".localized) \(1)")
        aVC.episodesVM = EpisodesVM(week: aWeek)
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    @IBAction func btnDooRooWaPressed(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        sideMenuController?.isLeftViewSwipeGestureEnabled = false
        imgViewGate.animate(animations: [AnimationType.zoom(scale: 0.9)], initialAlpha: 1)
        imgViewGate.image = arrImages.first
        imgViewGate.animationImages = arrImages
        imgViewGate.animationDuration = 1.0
        imgViewGate.animationRepeatCount = 1
        imgViewGate.startAnimating()
        imgViewGate.image = arrImages.last
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let videoUrl = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
            if let videoURL = URL(string: videoUrl) {
                let playerViewController = AVPlayerViewController()
                let player = AVPlayer(url: videoURL)
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.videoGravity = .resizeAspectFill
                    playerViewController.player?.play()
                    self.imgViewGate.image = self.arrImages.first
                    sender.isUserInteractionEnabled = true
                    self.sideMenuController?.isLeftViewSwipeGestureEnabled = true
                }
            }
        }
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        lblWeek.text = "week".localized + "1"
        stViewMain.isHidden = true
        addObservers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if UserDefaults.shared.isAppFirstLaunch() {
                let aVC = IntroVC.instance()
                aVC.modalTransitionStyle = .crossDissolve
                aVC.modalPresentationStyle = .overCurrentContext
                aVC.introTutorialProtocol = self
                self.present(aVC, animated: true)
            } else {
                self.tutorialSkipped()
            }
        }
    }
    
    fileprivate func animateUI() {
        stViewMain.animate(animations: [AnimationType.from(direction: .bottom, offset: 200), AnimationType.zoom(scale: 0.8)], delay: 0.4, duration: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7)
        animateStartWeekUI()
        
        let animationConfig = SPPerspectiveConfig.iOS14WidgetAnimatable
        animationConfig.animationDuration = 15
        animationConfig.shadowConfig = .none
        imgViewWeeklyProgress.applyPerspective(animationConfig)
    }
    
    fileprivate func animateStartWeekUI() {
        imgViewStartWeekLayers.transform = .identity
        viewStartWeekBubble.transform = .identity
        imgViewStartWeekRipples.transform = .identity
        
        imgViewStartWeekMovingLayers.transform = CGAffineTransform(translationX: -(AppConst.ScreenWidth - 40), y: -220)
        UIView.animate(withDuration: 15, delay: 0, options: [.autoreverse, .repeat, .curveEaseInOut], animations: {
            self.imgViewStartWeekMovingLayers.transform = .identity
            self.imgViewStartWeekLayers.transform = CGAffineTransform(translationX: (AppConst.ScreenWidth - 40), y: 220)
            self.viewStartWeekBubble.transform = CGAffineTransform(scaleX: 3, y: 3)
        })
        
        UIView.animate(withDuration: 4, delay: 0, options: [.autoreverse, .repeat, .curveEaseInOut], animations: {
            self.imgViewStartWeekRipples.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        })
    }
    
    /// Adding observers
    fileprivate func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    /// Removing all observers
    fileprivate func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    /// App moved to foreground
    @objc fileprivate func appMovedToForeground() {
        restartStartWeekAnimation()
    }
    
    fileprivate func restartStartWeekAnimation() {
        if !stViewMain.isHidden {
            animateStartWeekUI()
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
extension HomeVC: IntroTutorialProtocol {
    func tutorialSkipped() {
        stViewMain.isHidden = false
        animateUI()
    }
}
