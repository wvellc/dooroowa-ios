//
//  SplashVC.swift
//  DooRooWa
//
//  Created by Vision on 13/03/23.
//

import UIKit
import ViewAnimator
import Ripples

class SplashVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewRays: UIView!
    @IBOutlet weak var imgViewLogo: UIImageView!
    
    //MARK: - Variables
    private var arrImages = [#imageLiteral(resourceName: "imgLogoDoorClosed"), #imageLiteral(resourceName: "imgLogo")]
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        removeObservers()
        print("Splash screen released from memory")
    }
    
    //MARK: - IBActions
    
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    func doInitialSettings() {
        addObservers()
        imgViewLogo.animate(animations: [AnimationType.zoom(scale: 0.2)], usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6)
        self.imgViewLogo.image = arrImages.first
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.imgViewLogo.animationImages = self.arrImages
            self.imgViewLogo.animationDuration = 1.0
            self.imgViewLogo.animationRepeatCount = 1
            self.imgViewLogo.startAnimating()
            self.imgViewLogo.image = self.arrImages.last
            self.animateSplash()
        }
    }
    
    /// Animating splash logo
    fileprivate func animateSplash() {
        viewRays.transform = .identity
        viewRays.layer.cornerRadius = 0
        viewRays.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            let ripple = Ripples()
            ripple.radius = 300
            ripple.backgroundColor = ColorsConst.AppYellow?.cgColor
            ripple.rippleCount = 3
            ripple.speed = 2.5
            self.view.layer.insertSublayer(ripple, at: 0)
            ripple.position = self.view.center
            ripple.start()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.viewRays.alpha = 0.95
                UIView.animate(withDuration: 0.7, delay: 0, options: [.curveLinear, .allowUserInteraction, .beginFromCurrentState]) {
                    self.viewRays.alpha = 1
                }
                UIView.animate(withDuration: 1.5, delay: 0, options: [.curveLinear, .allowUserInteraction, .beginFromCurrentState]) {
                    self.viewRays.isHidden = false
                    self.viewRays.layer.cornerRadius = 40
                    self.viewRays.transform = CGAffineTransform(scaleX: 120, y: 120)
                } completion: { isCompleted in
                    if isCompleted {
                        AppConst.APPDELEGATE.navigateToAuthenticationOrDashboardView()
                    }
                }
            }
            
        }
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
    @objc func appMovedToForeground() {
        animateSplash()
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
