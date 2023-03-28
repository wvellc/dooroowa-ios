//
//  ToolsVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/27/23.
//

import UIKit

class ToolsVC: UIViewController {

    static func instance() -> ToolsVC {
       return ToolsVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.tools)
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
        print("Tools screen released from memory")
    }
    
    //MARK: - IBActions
    
    @IBAction func btnMenuPressed(_ sender: UIBarButtonItem) {
        sideMenuController?.showLeftView()
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        title = "tools".localized
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
