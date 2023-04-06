//
//  SideMenuVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/24/23.
//

import UIKit
import LGSideMenuController
import ViewAnimator
import Combine

class SideMenuVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var tblSideMenu: UITableView!
    
    //MARK: - Variables

    private var tblDataSource: TableViewDataSource<MenuCell,String>?
    private var tblDelegate: TableViewDelegate?
    
    private var arrMenu = [String]()
    private var selectedScreen = "home"
    private var sideMenuVM = SideMenuVM()
    private var cancellables = Set<AnyCancellable>()

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
        registerCell()
        bindViewModel()
        configureTableView()
    }
    
    fileprivate func bindViewModel() {
        sideMenuVM.arrMenu.sink { [weak self] (menu) in
            self?.arrMenu = menu
            self?.tblDataSource?.arrItems = self?.arrMenu
            self?.tblSideMenu.reloadData()
        }.store(in: &cancellables)
    }
    
    /// Register table view cells
    fileprivate func registerCell() {
        /* Registering Xib (view/cell) to table view */
        tblSideMenu.register(UINib(nibName:"MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        /* Assigning empty view to footer view */
        tblSideMenu.tableFooterView = UIView()
        /* Reload table view */
        tblSideMenu.reloadData()
    }
    
    fileprivate func configureTableView() {
        //Table View DataSource
        self.tblDataSource = TableViewDataSource(identifier: "MenuCell", items: arrMenu, configureCell: { [weak self] (cell, item, indexPath) in
            guard let self else { return }
            cell.configureData(indx: indexPath, title: self.arrMenu[indexPath.row], selected: self.selectedScreen)
        })

        //Table View Delegate
        self.tblDelegate = TableViewDelegate()
        
        ///Table view selection action
        self.tblDelegate?.tblDidSelectRowAt = { [weak self] (indexPath) in
            self?.didTapRowAt(indexPath)
        }
        
        //Reloading table view with animation after assigning delegate and data source
        DispatchQueue.main.async {
            self.tblSideMenu.delegate = self.tblDelegate
            self.tblSideMenu.dataSource = self.tblDataSource
            self.tblSideMenu.reloadData()
        }
    }
    
    fileprivate func didTapRowAt(_ indexPath: IndexPath) {
        self.selectedScreen = self.arrMenu[indexPath.row]
        self.tblSideMenu.reloadData()
        var aNextVC: UIViewController?
        switch self.selectedScreen {
        case "home":
            aNextVC = HomeVC.instance()
            break
        case "episodes":
            aNextVC = WeeksVC.instance()
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
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
