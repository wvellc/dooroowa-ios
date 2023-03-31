//
//  UICollectionViewExtension.swift
//  DooRooWa
//
//  Created by Vision on 31/03/23.
//

import UIKit
import ViewAnimator

extension UICollectionView {
    
    ///Animate cells from bottom
    func animateCells(offset:CGFloat = 100, isVertical: Bool = true) {
       DispatchQueue.main.async {
          let animations = [AnimationType.vector(isVertical ? CGVector(dx: 0, dy: offset) :  CGVector(dx: offset, dy: 0))]
          UIView.animate(views: self.visibleCells, animations: animations, duration: 0.6)
       }
    }
}
