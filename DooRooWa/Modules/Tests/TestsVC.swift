//
//  TestsVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/27/23.
//

import UIKit

class TestsVC: UIViewController {

    static func instance() -> TestsVC {
       return TestsVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.tests)
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
        print("Tests screen released from memory")
    }
    
    //MARK: - IBActions
    
    @IBAction func btnMenuPressed(_ sender: UIBarButtonItem) {
        sideMenuController?.hideLeftView()
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        
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
