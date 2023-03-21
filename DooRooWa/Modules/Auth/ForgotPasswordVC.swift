//
//  ForgotPasswordVC.swift
//  DooRooWa
//
//  Created by iOS Developer 3 on 20/03/23.
//

import UIKit
import ViewAnimator


protocol ForgotEmailProtocol {
   func updated(email: String?)
}
class ForgotPasswordVC: UIViewController {
   
   static func instance() -> ForgotPasswordVC {
      return ForgotPasswordVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.auth)
   }
   
   //MARK: - IBOutlets
   
   @IBOutlet weak var lblDescription: UILabel!
   @IBOutlet weak var imgViewLogo: UIImageView!
   @IBOutlet weak var txtEmail: CustomTextField!
   @IBOutlet weak var stViewInfo: UIStackView!
   @IBOutlet weak var stViewFooterButtons: UIStackView!
   
   //MARK: - Variables
   
   var userModel = UserModel()
   var forgotEmailProtocol: ForgotEmailProtocol?
   
   //MARK: - View Life Cycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      /* Initial setup when view load */
      doInitialSettings()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.navigationController?.setNavigationBarHidden(false, animated: true)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      self.navigationController?.setNavigationBarHidden(true, animated: true)
   }
   
   deinit {
       print("Forgot Password screen released from memory")
   }
   
   //MARK: - IBActions
   
   @IBAction func txtDidChange(_ sender: CustomTextField) {
      let clrError = ColorsConst.PlaceholderError
      let clrPlaceholder = ColorsConst.Border
      if sender == txtEmail {
         userModel.email = sender.text
         txtEmail.bottomBorderColor = Validator.isEmailAddress(userModel.email ?? "") ? clrPlaceholder : clrError
      }
   }
   
   @IBAction func btnResetPasswordPressed(_ sender: UIButton) {
      if isValid() {
         forgotEmailProtocol?.updated(email: userModel.email)
         AlertView.show(title: "Password Reset Successfully", message: "Password has been sent to your email", yesButtonTitle: "OK", alertType: .okButton , parent: self) { isOk in
            if isOk {
               self.navigationController?.popViewController(animated: true)
            }
         }
      }
   }
   
   @IBAction func btnBackToSignInPressed(_ sender: UIButton) {
      self.navigationController?.popViewController(animated: true)
   }
   
   //MARK: - Class Functions
   
   /// Initial settings when view loads
   fileprivate func doInitialSettings() {
      if let email = userModel.email {
         txtEmail.text = email
      }
      DispatchQueue.main.async() {
         self.animateUI()
      }
   }
   
   fileprivate func animateUI() {
      lblDescription.animate(animations: [], delay: 0.1, duration: 0.3)
      imgViewLogo.animate(animations: [AnimationType.from(direction: .bottom, offset: 50), AnimationType.zoom(scale: 0.6)], delay: 0.2)
      stViewInfo.animate(animations: [AnimationType.from(direction: .bottom, offset: 200), AnimationType.zoom(scale: 0.8)], delay: 0.4, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6)
      stViewFooterButtons.animate(animations: [AnimationType.from(direction: .bottom, offset: 200), AnimationType.zoom(scale: 0.8)], delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7)
   }
   
   /// Checking validation and returns true/false
   fileprivate func isValid() -> Bool {
      if !Validator.isEmailAddress(userModel.email ?? "") {
         txtEmail.becomeFirstResponder()
         return false
      }
      return true
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
