//
//  NoDataView.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/23/23.
//

import UIKit

typealias NoDataComplitionHandler = (Bool) -> Void

class NoDataView: UIView {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imgViewNoData: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var constImgViewHeight: NSLayoutConstraint!
    
    //MARK: - Variables
    
    private var imgNoData: UIImage?
    private var title: String?
    private var message: String?
    private var parent: UIViewController?
    private var handler: NoDataComplitionHandler?
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    //MARK: - IBActions
    
    @IBAction func btnRetryPressed(_ sender: UIButton) {
       /* Retry or any action */
       handler?(true)
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
       if let img = imgNoData{
          imgViewNoData.image = img
       } else {
          imgViewNoData.isHidden = true
       }
       if let title = title{
          lblTitle.text = title
       } else {
          lblTitle.isHidden = true
       }
       if let msg = message{
          lblMessage.text = msg
       } else {
          lblMessage.isHidden = true
       }
    }

    
    /// Showing no data view with options
    static func showNoData(onView: UIView? = nil, noDataImage:UIImage?, noDataImgHeight: CGFloat = 135, title:String?, message:String?, x:CGFloat = 0, y:CGFloat = 250, width:CGFloat = AppConst.ScreenWidth, height:CGFloat = 200, adAtZeroIndex: Bool = false, isHapticAlertOn:Bool = true, imgAlpha:CGFloat = 1.0, parent: UIViewController, handler: NoDataComplitionHandler?) {
        parent.view.layoutIfNeeded()
       hideNoDataView(onView: onView, parent: parent)
       guard let aView = Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)?.first as? NoDataView else {
             return
       }
       aView.tag = 550
       aView.frame = CGRect(x: x, y: y, width: width, height: height)
       aView.parent = parent
       aView.imgNoData = noDataImage
       aView.imgViewNoData.alpha = imgAlpha
       aView.title = title
       aView.message = message
       aView.handler = handler
       aView.constImgViewHeight.constant = noDataImgHeight
       aView.doInitialSettings()
       if let view = onView {
          if adAtZeroIndex {
             view.insertSubview(aView, at: 0)
          } else {
             view.addSubview(aView)
          }
       } else {
          if adAtZeroIndex {
              parent.view.insertSubview(aView, at: 0)
          } else {
              parent.view.addSubview(aView)
          }
       }
       if isHapticAlertOn {
           parent.hapticAlert()
       }
    }
    
    /// Fech no data view
    static func getNoDataView(onView: UIView? = nil, parent: UIViewController) -> NoDataView? {
        if let mainView = onView, let aView = mainView.viewWithTag(550) {
           aView.removeFromSuperview()
        } else if let aView = parent.view.viewWithTag(550) {
          return aView as? NoDataView
       }
       return nil
    }
    
    /// Remove no data view
    static func hideNoDataView(onView: UIView? = nil, parent: UIViewController) {
       if let mainView = onView, let aView = mainView.viewWithTag(550) {
          aView.removeFromSuperview()
       } else if let aView = parent.view.viewWithTag(550) {
          aView.removeFromSuperview()
       }
    }
    
}
