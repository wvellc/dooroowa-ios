//
//  SettingsVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/27/23.
//

import UIKit
import ViewAnimator

class SettingsVC: UIViewController {

    static func instance() -> SettingsVC {
       return SettingsVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.settings)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblSettings: UITableView!
    @IBOutlet weak var viewLogout: UIView!

    //MARK: - Variables
    
    var episodesVM: EpisodesVM?
    
    private var tblDataSource: TableViewDataSource<SettingCell,String>?
    private var tblDelegate: TableViewDelegate?
    private var arrEpisodes = [EpisodeModel]()
    private var arrCells = [String]()
    
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    UserDefaults.shared.clearAllUserDefaultData()
                    AppConst.APPDELEGATE.navigateToAuthenticationOrDashboardView()
                }
            }
        }
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        title = "settings".localized
        arrCells = ["change_password", "subscriptions", "notification_settings", "terms_and_conditions", "privacy_policy", "delete_account"]
        registerCell()
        configureTableView()
    }
    
    /// Register table view cells
    fileprivate func registerCell() {
        /* Registering Xib (view/cell) to table view */
        tblSettings.register(UINib(nibName:"SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")

        /* Reload table view */
        tblSettings.reloadData()
    }

    fileprivate func configureTableView() {
        //Table View DataSource
        self.tblDataSource = TableViewDataSource(identifier: "SettingCell", items: arrCells, configureCell: { (cell, item, indexPath) in
            cell.configureData(indx: indexPath, title: item)
        })

        //Table View Delegate
        self.tblDelegate = TableViewDelegate()
        
        ///Table view selection action
        self.tblDelegate?.tblDidSelectRowAt = { [weak self] (indexPath) in
            if let row = self?.arrCells[indexPath.row] {
                self?.navigate(to: row)
            }
//            let aVC = EpisodeDetailsVC.instance()
//            self?.navigationController?.pushViewController(aVC, animated: true)
        }
        
        //Reloading table view with animation after assigning delegate and data source
        DispatchQueue.main.async {
            self.tblSettings.delegate = self.tblDelegate
            self.tblSettings.dataSource = self.tblDataSource
            self.tblSettings.reloadDataWithAnimation(delegate: self.tblDelegate)
            self.viewLogout.animate(animations: [AnimationType.from(direction: .bottom, offset: 50), AnimationType.zoom(scale: 0.8)], delay: 0.7, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3)
        }
    }
    
    fileprivate func navigate(to: String) {
        switch to {
        case "change_password":
            break
        case "subscriptions":
            break
        case "notification_settings":
            if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
            break
        case "terms_and_conditions":
            let aVC = InfoVC.instance()
            self.navigationController?.pushViewController(aVC, animated: true)
            break
        case "privacy_policy":
            let aVC = InfoVC.instance()
            aVC.objTitle = "privacy_policy".localized
            self.navigationController?.pushViewController(aVC, animated: true)
            break
        case "delete_account":
            AlertView.show(title: "confrimation_message_delete_account".localized, message: "", yesButtonTitle: "delete".localized, alertType: .yesNoButton, parent: self) { isDelete in
                if isDelete {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        UserDefaults.shared.clearAllUserDefaultData()
                        AppConst.APPDELEGATE.navigateToAuthenticationOrDashboardView()
                    }
                }
            }
            break
        default:
            break
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
