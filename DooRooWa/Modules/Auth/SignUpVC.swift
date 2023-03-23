//
//  SignUpVC.swift
//  DooRooWa
//
//  Created by iOS Developer 3 on 21/03/23.
//

import UIKit
import ViewAnimator

class SignUpVC: UIViewController {
    
    static func instance() -> SignUpVC {
        return SignUpVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.auth)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var txtName: CustomTextField!
    @IBOutlet weak var txtEmail: CustomTextField!
    @IBOutlet weak var txtPhone: CustomTextField!
    @IBOutlet weak var txtPassword: CustomTextField!
    @IBOutlet weak var stViewInfo: UIStackView!
    @IBOutlet weak var viewTermsAndConditions: UIView!
    @IBOutlet weak var btnIAgree: UIButton!
    @IBOutlet weak var stViewFooterButtons: UIStackView!
    
    //MARK: - Variables
    
    private var userModel = UserModel()
    private var iAgreeToTermsAndConditions = false
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    deinit {
        print("Sign Up screen released from memory")
    }
    
    //MARK: - IBActions
    
    @IBAction func txtDidChange(_ sender: CustomTextField) {
        let clrError = ColorsConst.PlaceholderError
        let clrPlaceholder = ColorsConst.Border
        if sender == txtName {
            userModel.name = sender.text
            sender.bottomBorderColor = (userModel.name ?? "").trim().count > 1 ? clrPlaceholder : clrError
        } else if sender == txtEmail {
            userModel.email = sender.text
            sender.bottomBorderColor = Validator.isEmailAddress(userModel.email ?? "") ? clrPlaceholder : clrError
        } else if sender == txtPhone {
            userModel.phone = sender.text
            sender.bottomBorderColor = Validator.isPhoneNumber(userModel.phone ?? "") ? clrPlaceholder : clrError
        } else if sender == txtPassword {
            userModel.password = sender.text
            sender.bottomBorderColor = Validator.isPassword(userModel.password ?? "") ? clrPlaceholder : clrError
        }
    }
    
    @IBAction func btnIAgreeTermsAndConditionsPressed(_ sender: UIButton) {
        iAgreeToTermsAndConditions = !iAgreeToTermsAndConditions
        btnIAgree.setImage(iAgreeToTermsAndConditions ? #imageLiteral(resourceName: "svgCheck") : #imageLiteral(resourceName: "svgUncheck"), for: .normal)
    }
    
    @IBAction func btnTermsAndConditionsPressed(_ sender: UIButton) {
        let aVC = InfoVC.instance()
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    @IBAction func btnRegisterPressed(_ sender: UIButton) {
        //             if isValid() {
        userModel.name = "Jacob Hill"
        userModel.id = 1
        userModel.email = "jacobhill1122@gmail.com"
        userModel.phone = "1234567890"
        if let aData = JsonObjectManager().modelToJson(model: userModel) {
            UserDefaults.shared.saveCustomObject(aData, key: .user)
            AppConst.APPDELEGATE.navigateToAuthenticationOrDashboardView(false)
        }
        //             }
    }
    
    @IBAction func btnAlreadyHaveAnAccountPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        DispatchQueue.main.async() {
            self.animateUI()
        }
    }
    
    fileprivate func animateUI() {
        imgViewLogo.animate(animations: [AnimationType.from(direction: .bottom, offset: 200), AnimationType.zoom(scale: 0.8)], delay: 0.2)
        stViewInfo.animate(animations: [AnimationType.from(direction: .bottom, offset: 200), AnimationType.zoom(scale: 0.8)], delay: 0.4, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7)
        stViewFooterButtons.animate(animations: [AnimationType.from(direction: .bottom, offset: 200), AnimationType.zoom(scale: 0.8)], delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7)
    }
    
    /// Checking validation and returns true/false
    fileprivate func isValid() -> Bool {
        if (userModel.name ?? "").trim().count < 1 {
            txtName.becomeFirstResponder()
            return false
        } else if !Validator.isEmailAddress(userModel.email ?? "") {
            txtEmail.becomeFirstResponder()
            return false
        } else if !Validator.isPhoneNumber(userModel.phone ?? "") {
            txtPhone.becomeFirstResponder()
            return false
        } else if !Validator.isPassword(userModel.password ?? "") {
            txtPassword.becomeFirstResponder()
            return false
        } else if !iAgreeToTermsAndConditions {
            shakeView(view: viewTermsAndConditions)
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
