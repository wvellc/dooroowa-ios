//
//  UIViewExtension.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/4/23.
//

import UIKit

extension UIView {
    //MARK: - Animations
    
    /// show hidden view with animation
    func showWithAnimation(duration: TimeInterval = 0.3) {
        DispatchQueue.main.async {
            self.isHidden = true
            self.alpha = 0
            UIView.animate(withDuration: duration, animations: {
                self.isHidden = false
                self.alpha = 1
            })
        }
    }
    
    /// Hide view with animation
    func hideWithAnimation(duration: TimeInterval = 0.3) {
        DispatchQueue.main.async {
            self.isHidden = false
            self.alpha = 1
            UIView.animate(withDuration: duration, animations: {
                self.isHidden = true
                self.alpha = 0
            })
        }
    }
}
