//
//  UIViewControllerExtension.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/22/23.
//

import Foundation
import UIKit
import ViewAnimator

extension UIViewController {
    
    /// Shake view
    func shakeView(view: UIView) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 8, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 8, y: view.center.y))
        view.layer.add(animation, forKey: "position")
    }
    
    //MARK: - Utilities
    /// Haptic feedback
    func hapticAlert(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
         let generator = UIImpactFeedbackGenerator(style: style)
         generator.impactOccurred()
    }
}
