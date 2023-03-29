//
//  SideMenuVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/24/23.
//

import UIKit
import LGSideMenuController
import ViewAnimator

class SideMenuVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var tblSideMenu: UITableView!
    
    //MARK: - Variables

    var arrMenu = [String]()
    var selectedScreen = "home"
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        print("Side Menu screen released from memory")
    }
    
    //MARK: - IBActions
    
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        arrMenu = ["home", "episodes", "tools", "tests", "profile", "settings"]
        registerCell()
    }
    
    /// Register table view cells
    fileprivate func registerCell() {
        /* Registering Xib (view/cell) to table view */
        tblSideMenu.register(UINib(nibName:"MenuCell" , bundle: nil), forCellReuseIdentifier: "MenuCell")
        /* Assigning empty view to footer view */
        tblSideMenu.tableFooterView = UIView()
        /* Reload table view */
        tblSideMenu.reloadData()
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
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedScreen = arrMenu[indexPath.row]
        tableView.reloadData()
        var aNextVC: UIViewController?
        switch selectedScreen {
        case "home":
            aNextVC = HomeVC.instance()
            break
        case "episodes":
            aNextVC = EpisodesVC.instance()
            break
        case "tools":
            aNextVC = ToolsVC.instance()
            break
        case "tests":
            aNextVC = TestsVC.instance()
            break
        case "profile":
            aNextVC = ProfileVC.instance()
            break
        case "settings":
            aNextVC = SettingsVC.instance()
            break
        default:
            break
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let aVC = aNextVC, let aNavController = self.sideMenuController?.rootViewController as? UINavigationController {
                aNavController.setViewControllers([aVC], animated: false)
            }
            self.sideMenuController?.hideLeftView()
        }
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let aCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell else { return UITableViewCell() }
        aCell.configureData(indx: indexPath, title: arrMenu[indexPath.row], selected: selectedScreen)
        return aCell
    }
}
