//
//  HomeVC.swift
//  DooRooWa
//
//  Created by Vision on 15/03/23.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - IBOutlets
    
    //MARK: - Variables
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    //MARK: - IBActions
    
    @IBAction func btnLogoutPressed(_ sender: UIButton) {
        USERDEFAULTS.clearAllUserDefaultData()
        AppConst.APPDELEGATE.navigateToAuthenticationOrDashboardView()
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    func doInitialSettings() {
        
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
