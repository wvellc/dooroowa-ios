//
//  SettingsVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/27/23.
//

import UIKit

class SettingsVC: UIViewController {

    static func instance() -> SettingsVC {
       return SettingsVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.settings)
    }
    
    //MARK: - IBOutlets
    
    //MARK: - Variables
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        print("Settings screen released from memory")
    }
    
    //MARK: - IBActions
    
    @IBAction func btnMenuPressed(_ sender: UIBarButtonItem) {
        sideMenuController?.showLeftView()
    }
    
    @IBAction func btnLogoutPressed(_ sender: UIButton) {
        AlertView.show(title: "confrimation_message_logout".localized, message: "", yesButtonTitle: "logout".localized, alertType: .yesNoButton, parent: self) { isDelete in
            if isDelete {
                UserDefaults.shared.clearAllUserDefaultData()
                AppConst.APPDELEGATE.navigateToAuthenticationOrDashboardView()
            }
        }
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        title = "settings".localized
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
