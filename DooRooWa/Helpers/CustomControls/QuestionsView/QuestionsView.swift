//
//  QuestionsView.swift
//  DooRooWa
//
//  Created by iOS Developer 3 on 04/04/23.
//

import UIKit

/// Questions View Action Protocol Method
typealias QuestionsComplitionHandler = (Bool) -> Void

class QuestionsView: UIView {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imgViewBubbleBg: UIStackView!
    @IBOutlet weak var btnBackground: UIButton!
    @IBOutlet weak var lblQuestionNumber: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var stViewActionButtons: UIStackView!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var stViewNext: UIStackView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtViewAnswer: UITextView!
    
    //MARK: - Variables
    var isAnimate = true
    var handler: QuestionsComplitionHandler?
    var parent: UIViewController?
    var strTtile: String?
    var strMessage: String?
    var isAllowTapToDissmiss = true
    var strYesButtonTitle: String?
    var strCancelButtonTitle: String!
    
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
        /* Cancel button pressed alert action */
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.handler?(false)
        }
        
        /* Dismiss view with animation */
        dismissAnimation()
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    func doInitialSettings() {
        /* Setup view layout */
        txtViewAnswer.layoutIfNeeded()
        txtViewAnswer.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        
        //
        //      if let title = strYesButtonTitle {
        //         stViewOk.isHidden = false
        //         btnOk.setTitle(title, for: .normal)
        //      } else {
        //         stViewOk.isHidden = true
        //      }
        //
        //      btnCancel.setTitle(strCancelButtonTitle, for: .normal)
        
        //      if currentAlertType == AlertActionType.none {
        //         stViewOk.isHidden = true
        //         btnCancel.isHidden = true
        //         stViewActionButtons.isHidden = true
        //      }  else if currentAlertType == AlertActionType.yesNoButton {
        //         btnCancel.isHidden = false
        //         stViewOk.isHidden = false
        //         stViewActionButtons.isHidden = false
        //         stViewOk.alignment = .fill
        //         stViewOk.layoutIfNeeded()
        //      } else {
        //         stViewActionButtons.isHidden = false
        //         stViewOk.alignment = .center
        //         btnCancel.isHidden = true
        //         stViewOk.isHidden = false
        //         stViewOk.layoutIfNeeded()
        //      }
        
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
                     allowTapToDissmiss:Bool = true,
                     animate:Bool = true,
                     x:CGFloat = 0,
                     y:CGFloat = 0,
                     width:CGFloat = UIScreen.main.bounds.width,
                     height:CGFloat = UIScreen.main.bounds.height,
                     adAtZeroIndex: Bool = false,
                     parent: UIViewController,
                     handler: QuestionsComplitionHandler?) {
        parent.view.layoutIfNeeded()
        //      hideQuestionsView(parent: parent)
        guard let aView = Bundle.main.loadNibNamed("QuestionsView", owner: self, options: nil)?.first as? QuestionsView else {
            return
        }
        aView.tag = 818
        aView.frame = CGRect(x: x, y: y, width: width, height: height)
        aView.isAllowTapToDissmiss = allowTapToDissmiss
        aView.isAnimate = animate
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
    static func get(onView: UIView? = nil, parent: UIViewController) -> QuestionsView? {
        if let mainView = onView, let aView = mainView.viewWithTag(818) {
            return aView as? QuestionsView
        } else if let aView = parent.view.viewWithTag(818) {
            return aView as? QuestionsView
        } else if let aView = parent.navigationController?.view?.viewWithTag(818) {
            return aView as? QuestionsView
        }
        return nil
    }
    
    /// Remove no data view
    static func hide(onView: UIView? = nil, parent: UIViewController) {
        if let mainView = onView, let aView = mainView.viewWithTag(818) {
            aView.removeFromSuperview()
        } else if let aView = parent.view.viewWithTag(818) {
            aView.removeFromSuperview()
        } else if let aView = parent.navigationController?.view?.viewWithTag(818) {
            aView.removeFromSuperview()
        }
    }
    
}
