//
//  HomeVC.swift
//  DooRooWa
//
//  Created by Vision on 15/03/23.
//

import UIKit

class HomeVC: UIViewController {
    
    static func instance() -> HomeVC {
       return HomeVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.home)
    }
    
    //MARK: - IBOutlets
    
    //MARK: - Variables
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = UserDefaults.shared.retriveCustomObject(.user) as? Data,
           let user = try? JSONDecoder().decode(UserModel.self, from: data),
           let name = user.name?.components(separatedBy: " ").first {
            title = "welcome".localized + "\(name)!"
        } else {
            title = "welcome".localized
        }
    }
    
    deinit {
        print("Home screen released from memory")
    }
    
    //MARK: - IBActions
    
    @IBAction func btnMenuPressed(_ sender: UIBarButtonItem) {
        sideMenuController?.showLeftView()
    }

    @IBAction func btnNotificationsPressed(_ sender: UIBarButtonItem) {
        let aVC = NotificationsVC.instance()
        self.navigationController?.pushViewController(aVC, animated: true)
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if UserDefaults.shared.isAppFirstLaunch() {
                let aVC = IntroVC.instance()
                aVC.modalTransitionStyle = .crossDissolve
                aVC.modalPresentationStyle = .overCurrentContext
                aVC.introTutorialProtocol = self
                self.present(aVC, animated: true)
            } else {
                self.tutorialSkipped()
            }
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
extension HomeVC: IntroTutorialProtocol {
    func tutorialSkipped() {
        
    }
}
