//
//  NotificationsVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/23/23.
//

import UIKit
import SwipeCellKit

class NotificationsVC: UIViewController {
    
    static func instance() -> NotificationsVC {
        return NotificationsVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.common)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblNotifications: UITableView!
    @IBOutlet weak var barBtnClearAll: UIBarButtonItem!

    //MARK: - Variables
    
    private var tblDataSource: TableViewDataSource<NotificationCell,NotificationModel>?
    private var tblDelegate: TableViewDelegate?

    private var arrNotifications = [NotificationModel]()
    private var notificationsVM = NotificationsVM()

    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        print("Notifications screen released from memory")
    }
    
    //MARK: - IBActions
    
    @IBAction func btnClearAllPressed(_ sender: UIBarButtonItem) {
        if arrNotifications.count > 0 {
            AlertView.show(title: "confrimation_message_clear_all_notifications".localized, message: "", yesButtonTitle: "clear_all".localized, alertType: .yesNoButton, parent: self) { isDelete in
                if isDelete {
                    self.notificationsVM.clearAllNotifications { [weak self] (notifications) in
                        self?.arrNotifications = notifications
                        self?.tblDataSource?.arrItems = self?.arrNotifications
                        self?.tblNotifications.reloadData()
                        self?.manageNoDataView()
                    }
                }
            }
        }
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        title = "notifications".localized
        registerCell()
        manageClearAllUI()
        configureTableView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.fetchNotifications()
        }
    }
    
    /// Register table view cells
    fileprivate func registerCell() {
        /* Registering Xib (view/cell) to table view */
        tblNotifications.register(UINib(nibName:"NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")

        /* Reload table view */
        tblNotifications.reloadData()
    }

    fileprivate func configureTableView() {
        //Table View DataSource
        self.tblDataSource = TableViewDataSource(identifier: "NotificationCell", items: arrNotifications, configureCell: { [weak self] (cell, item, indexPath) in
            cell.delegate = self
            cell.configureData(indx: indexPath, model: item)
        })

        //Table View Delegate
        self.tblDelegate = TableViewDelegate()
        
        //Reloading table view with animation after assigning delegate and data source
        DispatchQueue.main.async {
            self.tblNotifications.delegate = self.tblDelegate
            self.tblNotifications.dataSource = self.tblDataSource
            self.tblNotifications.reloadDataWithAnimation(delegate: self.tblDelegate)
        }
    }
    
    fileprivate func fetchNotifications() {
        notificationsVM.fetchNotifications {  [weak self] (notifications) in
            self?.arrNotifications = notifications
            self?.tblDataSource?.arrItems = self?.arrNotifications
            self?.tblNotifications.reloadData(delegate: self?.tblDelegate)
            self?.manageNoDataView()
        }
    }
        
    fileprivate func manageNoDataView() {
        manageClearAllUI()
        if arrNotifications.count > 0 {
            NoDataView.hideNoDataView(parent: self)
        } else {
            NoDataView.showNoData(noDataImage: #imageLiteral(resourceName: "svgNoNotifications"), title: "no_data_found".localized, message: nil, parent: self, handler: nil)
        }
    }
    
    fileprivate func manageClearAllUI() {
        if arrNotifications.count > 0 {
            barBtnClearAll.image = #imageLiteral(resourceName: "svgClearAll")
        } else {
            barBtnClearAll.image = nil
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
extension NotificationsVC: SwipeTableViewCellDelegate {
    
    //MARK: - SwipeTableViewCellDelegate Methods
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
       
       guard orientation == .right else { return nil }
       let delete = SwipeAction(style: .default, title: nil) { action, indexPath in
          //Action
           AlertView.show(title: "confrimation_message_delete_notification".localized, message: "", yesButtonTitle: "delete".localized, alertType: .yesNoButton, parent: self) { isDelete in
               if isDelete {
                   self.notificationsVM.delete(notification: self.arrNotifications[indexPath.row], at: indexPath.row) { [weak self] (notification) in
                       self?.arrNotifications.remove(at: indexPath.row)
                       self?.tblDataSource?.arrItems = self?.arrNotifications
                       self?.tblNotifications.deleteRows(at: [indexPath], with: .fade)
                       self?.manageNoDataView()
                   }
               }
           }
       }
        
       delete.image = #imageLiteral(resourceName: "svgDelete")
       delete.hidesWhenSelected = true
       delete.backgroundColor = .white
       return [delete]
    }
}
