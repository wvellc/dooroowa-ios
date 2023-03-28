//
//  AlertView.swift
//  DooRooWa
//
//  Created by iOS Developer 3 on 20/03/23.
//

import UIKit

/// Alert Action Protocol Method
typealias AlertComplitionHandler = (Bool) -> Void

class AlertView: UIView {
   
   enum AlertActionType {
      case none
      case okButton
      case yesNoButton
   }
   
   //MARK: - IBOutlets
   
   @IBOutlet weak var viewBackground: UIView!
   @IBOutlet weak var btnBackground: UIButton!
   @IBOutlet weak var lblTitle: UILabel!
   @IBOutlet weak var lblMessage: UILabel!
   @IBOutlet weak var stViewActionButtons: UIStackView!
   @IBOutlet weak var btnCancel: UIButton!
   @IBOutlet weak var stViewOk: UIStackView!
   @IBOutlet weak var btnOk: UIButton!
   
   //MARK: - Variables
   var isAnimate = true
   var handler: AlertComplitionHandler?
   var parent: UIViewController?
   var strTtile: String?
   var strMessage: String?
   var isAllowTapToDissmiss = true
   var strYesButtonTitle: String?
   var strCancelButtonTitle: String!
   var currentAlertType = AlertActionType.okButton
   
   /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
    // Drawing code
    }
    */
   
   //MARK: - IBActions
   
   @IBAction func btnOkPressed(_ sender: UIButton) {
      /* OK button pressed alert action */
      handler?(true)
      dismissAnimation()
   }
   
   @IBAction func btnDismissPressed(_ sender: UIButton) {
      
      if !isAllowTapToDissmiss && btnBackground == sender{
         /* Retuns if tap to dismiss is not allowed */
         return
      }
      
      if sender == btnCancel { //|| sender ==  sbtnBackground
         /* Cancel button pressed alert action */
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.handler?(false)
         }
      }
      
      /* Dismiss view with animation */
      dismissAnimation()
   }
   
   //MARK: - Class Functions
   
   /// Initial settings when view loads
   func doInitialSettings() {
      
      /* Setup view layout */
      if let title = strTtile {
         lblTitle.isHidden = false
         lblTitle.text = title
      } else {
         lblTitle.isHidden = true
      }
      
      if let msg = strMessage {
         lblMessage.isHidden = false
         lblMessage.text = msg
      } else {
         lblMessage.isHidden = true
      }
      
      if let title = strYesButtonTitle {
         stViewOk.isHidden = false
         btnOk.setTitle(title, for: .normal)
      } else {
         stViewOk.isHidden = true
      }
      
      btnCancel.setTitle(strCancelButtonTitle, for: .normal)
      
      if currentAlertType == AlertActionType.none {
         stViewOk.isHidden = true
         btnCancel.isHidden = true
         stViewActionButtons.isHidden = true
      }  else if currentAlertType == AlertActionType.yesNoButton {
         btnCancel.isHidden = false
         stViewOk.isHidden = false
         stViewActionButtons.isHidden = false
         stViewOk.alignment = .fill
         stViewOk.layoutIfNeeded()
      } else {
         stViewActionButtons.isHidden = false
         stViewOk.alignment = .center
         btnCancel.isHidden = true
         stViewOk.isHidden = false
         stViewOk.layoutIfNeeded()
      }
      
      /* View load(From bottom to identity) animation */
      self.viewBackground.layoutIfNeeded()
      if isAnimate {
         self.viewBackground.transform = CGAffineTransform(scaleX: 0, y: 0)
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
               self.viewBackground.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { [weak self] (isDone) in
               if isDone {
                  self?.viewBackground.transform = .identity
               }
            })
         }
      }
   }
   
   /// View dismiss with animation
   func dismissAnimation() {
      if isAnimate {
         self.viewBackground.transform = CGAffineTransform(scaleX: 1, y: 1)
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
               self.viewBackground.transform = CGAffineTransform(scaleX: 0, y: 0)
               self.removeFromSuperview()
            }, completion: nil)
         }
      } else {
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.removeFromSuperview()
         }
      }
   }
   
   /// Showing no data view with options
   static func show(onView: UIView? = nil,
                    title:String?,
                    message: String?,
                    yesButtonTitle: String,
                    strCancelButtonTitle: String = "cancel".localized,
                    alertType:AlertView.AlertActionType,
                    isShowCloseButton:Bool = true,
                    allowTapToDissmiss:Bool = true,
                    animate:Bool = true,
                    x:CGFloat = 0,
                    y:CGFloat = 0,
                    width:CGFloat = UIScreen.main.bounds.width,
                    height:CGFloat = UIScreen.main.bounds.height,
                    adAtZeroIndex: Bool = false,
                    parent: UIViewController,
                    handler: AlertComplitionHandler?) {
      parent.view.layoutIfNeeded()
      //      hideAlertView(parent: parent)
      guard let aView = Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)?.first as? AlertView else {
         return
      }
      aView.tag = 515
      aView.frame = CGRect(x: x, y: y, width: width, height: height)
      aView.strTtile = title
      aView.strMessage = message
      aView.isAllowTapToDissmiss = allowTapToDissmiss
      aView.isAnimate = animate
      aView.currentAlertType = alertType
      aView.strYesButtonTitle = yesButtonTitle
      aView.strCancelButtonTitle = strCancelButtonTitle
      aView.parent = parent
      aView.handler = handler
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
            parent.navigationController?.view?.addSubview(aView)
         }
      }
   }
   
   /// Fech no data view
   static func getAlertView(onView: UIView? = nil, parent: UIViewController) -> AlertView? {
      if let mainView = onView, let aView = mainView.viewWithTag(515) {
         return aView as? AlertView
      } else if let aView = parent.view.viewWithTag(515) {
         return aView as? AlertView
      } else if let aView = parent.navigationController?.view?.viewWithTag(515) {
         return aView as? AlertView
      }
      return nil
   }
   
   /// Remove no data view
   static func hideAlertView(onView: UIView? = nil, parent: UIViewController) {
      if let mainView = onView, let aView = mainView.viewWithTag(515) {
         aView.removeFromSuperview()
      } else if let aView = parent.view.viewWithTag(515) {
         aView.removeFromSuperview()
      } else if let aView = parent.navigationController?.view?.viewWithTag(515) {
         aView.removeFromSuperview()
      }
   }
   
}
