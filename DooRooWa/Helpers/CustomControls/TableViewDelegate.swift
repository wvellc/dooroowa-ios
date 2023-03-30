//
//  TableViewDelegate.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/30/23.
//

import UIKit
import ViewAnimator

class TableViewDelegate: NSObject, UITableViewDelegate {
    
    typealias didSelectRowAt = (IndexPath) -> Void
    typealias heightForRowAt = (IndexPath) -> CGFloat
    typealias willDisplayRowAt = (UITableViewCell, IndexPath) -> Void

    var tblDidSelectRowAt: didSelectRowAt?
    var tblHeightForRowAt: heightForRowAt?
    var tblWillDisplayCellRowAt: willDisplayRowAt?

    private var directionTopBottom = true
    private var showScrollAnimation = true
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tblHeightForRowAt?(indexPath) ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tblHeightForRowAt?(indexPath) ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblDidSelectRowAt?(indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       if directionTopBottom {
           if let tblWillDisplayCellRowAt {
               tblWillDisplayCellRowAt(cell, indexPath)
           } else {
               if let lyr = cell.contentView.subviews.first?.layer {
                   lyr.transform = CATransform3DMakeScale(0.5,0.5,1)
                   UIView.animate(withDuration: 0.3, animations: {
                       lyr.transform = CATransform3DMakeScale(1.07,1.07,1)
                   },completion: { finished in
                      UIView.animate(withDuration: 0.2, animations: {
                          lyr.transform = CATransform3DMakeScale(1,1,1)
                      })
                   })
               }
           }
       }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
       if translation.y > 0 {
          directionTopBottom = false
          // swipes from top to bottom of screen -> down
       } else {
          directionTopBottom = true
          // swipes from bottom to top of screen -> up
       }
    }
}
