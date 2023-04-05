//
//  SubscriptionsVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/5/23.
//

import UIKit
import SPPerspective
import ViewAnimator

class SubscriptionsVC: UIViewController {
    
    static func instance() -> SubscriptionsVC {
       return SubscriptionsVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.settings)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewSubscriptionImageBg: UIView!
    @IBOutlet weak var imgViewSubscription: UIImageView!
    @IBOutlet weak var stViewInfo: UIStackView!
    @IBOutlet weak var stViewFooterButtons: UIStackView!
    @IBOutlet weak var btnSubscribe: UIButton!
    
    //MARK: - Variables
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        removeObservers()
        print("Subscriptions screen released from memory")
    }
    
    //MARK: - IBActions
    
    
    @IBAction func btnSubscribePressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnTermsAndConditionsPresed(_ sender: UIButton) {
        let aVC = InfoVC.instance()
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        title = "subscriptions".localized
        btnSubscribe.setTitle("subscribe".localized + " 14.99$", for: .normal)
        addObservers()
        animateUI()
    }
        
    fileprivate func animateUI() {
        viewSubscriptionImageBg.animate(animations: [AnimationType.from(direction: .bottom, offset: 100), AnimationType.zoom(scale: 0.8)], delay: 0.4, duration: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7)
        stViewInfo.animate(animations: [AnimationType.from(direction: .bottom, offset: 150), AnimationType.zoom(scale: 0.8)], delay: 0.5, duration: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7)
        stViewFooterButtons.animate(animations: [AnimationType.from(direction: .bottom, offset: 200), AnimationType.zoom(scale: 0.8)], delay: 0.6, duration: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7)

        animateSubscriptionImage()
    }
    
    fileprivate func animateSubscriptionImage() {
        let animationConfig = SPPerspectiveConfig.iOS14WidgetAnimatable
        animationConfig.animationDuration = 10
        animationConfig.shadowConfig = .none
        imgViewSubscription.applyPerspective(animationConfig)
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
        animateSubscriptionImage()
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
