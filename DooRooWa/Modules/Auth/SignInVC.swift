//
//  SignInVC.swift
//  DooRooWa
//
//  Created by Vision on 14/03/23.
//

import UIKit
import ViewAnimator

class SignInVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var txtEmail: CustomTextField!
    @IBOutlet weak var txtPassword: CustomTextField!
    @IBOutlet weak var stViewInfo: UIStackView!
    @IBOutlet weak var stViewFooterButtons: UIStackView!
    
    //MARK: - Variables
    
    var userModel = UserModel()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - IBActions
    
    @IBAction func txtDidChange(_ sender: CustomTextField) {
        let clrError = ColorsConst.PlaceholderError
        let clrPlaceholder = ColorsConst.Border
        if sender == txtEmail {
            userModel.email = sender.text
            txtEmail.bottomBorderColor = Validator.isEmailAddress(userModel.email ?? "") ? clrPlaceholder : clrError
        } else if sender == txtPassword {
            userModel.password = sender.text
            sender.bottomBorderColor = Validator.isPassword(userModel.password ?? "") ? clrPlaceholder : clrError
        }
    }
    
    @IBAction func btnForgotPasswordPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        userModel.name = "Jacob Hill"
        userModel.id = 1
        userModel.email = "jacobhill1122@gmail.com"
        userModel.phone = "1234567890"
        if let aData = JsonObjectManager().modelToJson(model: userModel) {
            USERDEFAULTS.saveCustomObject(aData, key: .user)
            AppConst.APPDELEGATE.navigateToAuthenticationOrDashboardView()
        }
    }
    
    @IBAction func btnDontHaveAccountPressed(_ sender: UIButton) {
        
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    func doInitialSettings() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        DispatchQueue.main.async() {
            self.animateSignIn()
        }
    }
    
    fileprivate func animateSignIn() {
        animateLogo()
        stViewInfo.animate(animations: [AnimationType.from(direction: .bottom, offset: 200), AnimationType.zoom(scale: 0.8)], delay: 0.6, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7)
        stViewFooterButtons.animate(animations: [AnimationType.from(direction: .bottom, offset: 200), AnimationType.zoom(scale: 0.8)], delay: 0.7, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7)

    }
    
    fileprivate func animateLogo() {
        let cntr = imgViewLogo.center
        imgViewLogo.center.y = (AppConst.ScreenHeight / 2) - (imgViewLogo.frame.height / 2)
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7) {
            self.imgViewLogo.center = cntr
        }
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
