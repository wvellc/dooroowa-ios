//
//  UITableViewExtension.swift
//  DooRooWa
//
//  Created by Vision on 31/03/23.
//

import UIKit
import ViewAnimator

extension UITableView {
    
    ///Animate cells from bottom without scroll animation
    func reloadData(delegate: TableViewDelegate?) {
        delegate?.showScrollAnimation = false
        self.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            delegate?.showScrollAnimation = true
       }
    }
    
    ///Animate cells from bottom without scroll animation
    func reloadDataWithAnimation(delegate: TableViewDelegate?, offset:CGFloat = 100, isVertical: Bool = true) {
        delegate?.showScrollAnimation = false
        self.reloadData()
        self.animateCells(offset: offset, isVertical: isVertical)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            delegate?.showScrollAnimation = true
       }
    }
    
    ///Animate cells from bottom
    func animateCells(offset:CGFloat = 100, isVertical: Bool = true) {
       DispatchQueue.main.async {
          let animations = [AnimationType.vector(isVertical ? CGVector(dx: 0, dy: offset) :  CGVector(dx: offset, dy: 0))]
          UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
              self.alpha = 1
          }
          UIView.animate(views: self.visibleCells, animations: animations, duration: 0.6)
       }
    }
}
