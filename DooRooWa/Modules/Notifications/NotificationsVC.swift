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
    
    private var arrNotificaions = [NotificationModel]()
    private var directionTopBottom = true
    private var showScrollAnimation = true
    
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
        if arrNotificaions.count > 0 {
            AlertView.show(title: "confrimation_message_clear_all_notifications".localized, message: "", yesButtonTitle: "clear_all".localized, alertType: .yesNoButton, parent: self) { isDelete in
                if isDelete {
                    NotificationModel.clearAllNotifications { result in
                        switch result {
                        case .success(_):
                            self.arrNotificaions.removeAll()
                            self.tblNotifications.reloadData()
                        case .failure(let failure):
                            print(failure)
                        }
                        self.manageNoDataView()
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
        showScrollAnimation = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.fetchNotifications()
        }
    }
    
    /// Register table view cells
    fileprivate func registerCell() {
        /* Registering Xib (view/cell) to table view */
        tblNotifications.register(UINib(nibName:"NotificationCell" , bundle: nil), forCellReuseIdentifier: "NotificationCell")

        /* Reload table view */
        tblNotifications.reloadData()
    }
    
    fileprivate func reloadTable() {
        showScrollAnimation = false
        tblNotifications.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.showScrollAnimation = true
        }
    }
    
    fileprivate func fetchNotifications() {
        NotificationModel.fetchNotifications { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let notifications):
                self.arrNotificaions = notifications ?? []
//                self.tblNotifications.reloadData()
                self.animateCells(tbl: self.tblNotifications)
                self.reloadTable()
            case .failure(let failure):
                print(failure)
            }
            self.manageNoDataView()
        }
    }
        
    fileprivate func manageNoDataView() {
        manageClearAllUI()
        if arrNotificaions.count > 0 {
            NoDataView.hideNoDataView(parent: self)
        } else {
            NoDataView.showNoData(noDataImage: #imageLiteral(resourceName: "svgNoNotifications"), title: "no_data_found".localized, message: nil, parent: self, handler: nil)
        }
    }
    
    fileprivate func manageClearAllUI() {
        if arrNotificaions.count > 0 {
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
extension NotificationsVC: UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotificaions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let aCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell else { return UITableViewCell() }
        aCell.delegate = self
        aCell.configureData(indx: indexPath, model: arrNotificaions[indexPath.row])
        return aCell
    }
    
   
    //MARK: - SwipeTableViewCellDelegate Methods
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
       
       guard orientation == .right else { return nil }
       let delete = SwipeAction(style: .default, title: nil) { action, indexPath in
          //Action
           AlertView.show(title: "confrimation_message_delete_notification".localized, message: "", yesButtonTitle: "delete".localized, alertType: .yesNoButton, parent: self) { isDelete in
               if isDelete {
                   self.arrNotificaions[indexPath.row].deleteNotification { result in
                       switch result {
                       case .success(_):
                           self.arrNotificaions.remove(at: indexPath.row)
                           self.tblNotifications.deleteRows(at: [indexPath], with: .fade)
                       case .failure(let failure):
                           print(failure)
                       }
                       self.manageNoDataView()
                   }
               }
           }
       }
        
       delete.image = #imageLiteral(resourceName: "svgDelete")
       delete.hidesWhenSelected = true
       delete.backgroundColor = .white
       return [delete]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       let cell = cell as! NotificationCell
       if showScrollAnimation && directionTopBottom {
          cell.viewBg.layer.transform = CATransform3DMakeScale(0.5,0.5,1)
          UIView.animate(withDuration: 0.3, animations: {
             cell.viewBg.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
          },completion: { finished in
             UIView.animate(withDuration: 0.1, animations: {
                cell.viewBg.layer.transform = CATransform3DMakeScale(1,1,1)
             })
          })
       }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
       if translation.y > 0 {
          directionTopBottom = false
          // swipes from top to bottom of screen -> down
       } else {
          directionTopBottom = true
          // swipes from bottom to top of screen -> up
       }
    }
    
}

