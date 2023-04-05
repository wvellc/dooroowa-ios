//
//  ChangePasswordVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/5/23.
//

import UIKit
import ViewAnimator

class ChangePasswordVC: UIViewController {

    static func instance() -> ChangePasswordVC {
       return ChangePasswordVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.settings)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblChangePassword: UITableView!
    @IBOutlet weak var viewUpdate: UIView!
    
    //MARK: - Variables
    
    private var tblDataSource: TableViewDataSource<TextCell,ProfileModel>?
    private var tblDelegate: TableViewDelegate?
    private var userInfo: UserModel?
    private var arrCell = [ProfileModel]()
    private var changePasswordVM: ChangePasswordVM?
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        print("Change Password screen released from memory")
    }
    
    //MARK: - IBActions
    
    @IBAction func btnUpdatePasswordPressed(_ sender: UIButton) {
        if isValid() {
            AlertView.show(title: "password_update_successfully".localized, message: "remember_password".localized, yesButtonTitle: "ok".localized, alertType: .okButton, parent: self) { isDelete in
                if isDelete {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func txtDidChange(_ sender: CustomTextField) {
        let clrError = ColorsConst.PlaceholderError, clrPlaceholder = ColorsConst.Border
        let row = arrCell[sender.tag]
        switch row.key {
        case "old_password":
            userInfo?.oldPassword = sender.text
            sender.bottomBorderColor = (userInfo?.oldPassword ?? "").trim().count > 1 ? clrPlaceholder : clrError
            break
        case "new_password":
            userInfo?.password = sender.text
            sender.bottomBorderColor = Validator.isPassword(userInfo?.password ?? "") ? clrPlaceholder : clrError
            break
        case "confirm_password":
            userInfo?.confrimPassword = sender.text
            sender.bottomBorderColor = userInfo?.password == userInfo?.confrimPassword ? clrPlaceholder : clrError
            break
        default:
            break
        }
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        title = "change_password".localized
        userInfo = UserModel()
        changePasswordVM = ChangePasswordVM()
        registerCell()
        bindViewModel()
        configureTableView()
    }
    
    /// Register table view cells
    fileprivate func registerCell() {
        /* Registering Xib (view/cell) to table view */
        tblChangePassword.register(UINib(nibName:"TextCell", bundle: nil), forCellReuseIdentifier: "TextCell")

        /* Reload table view */
        tblChangePassword.reloadData()
    }
    
    fileprivate func bindViewModel() {
        changePasswordVM?.arrCells.bind { [weak self] (cell) in
            self?.arrCell = cell
            self?.tblDataSource?.arrItems = self?.arrCell
            self?.tblChangePassword.reloadData(delegate: self?.tblDelegate)
        }
    }

    fileprivate func configureTableView() {
        //Table View DataSource
        self.tblDataSource = TableViewDataSource(identifier: "TextCell", items: arrCell, configureCell: { [weak self] (cell, item, indexPath) in
            cell.configureData(indx: indexPath, model: item, userInfo: self?.userInfo, isEditingOn: true)
            cell.txtField.addTarget(self, action: #selector(self?.txtDidChange(_:)), for: .editingChanged)
        })

        //Table View Delegate
        self.tblDelegate = TableViewDelegate()
        
        //Reloading table view with animation after assigning delegate and data source
        DispatchQueue.main.async {
            self.tblChangePassword.delegate = self.tblDelegate
            self.tblChangePassword.dataSource = self.tblDataSource
            self.tblChangePassword.reloadDataWithAnimation(delegate: self.tblDelegate)
            self.viewUpdate.animate(animations: [AnimationType.from(direction: .bottom, offset: 50), AnimationType.zoom(scale: 0.8)], delay: 0.7, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3)
        }
    }
    
    /// Checking validation and returns true/false
    fileprivate func isValid() -> Bool {
        if (userInfo?.oldPassword ?? "").trim().count < 1 {
            becomeFirstResponder(key: "old_password")
            return false
        } else if !Validator.isPassword(userInfo?.password ?? "") {
            becomeFirstResponder(key: "new_password")
            return false
        } else if userInfo?.password != userInfo?.confrimPassword {
            becomeFirstResponder(key: "confirm_password")
            return false
        }
        return true
    }
    
    fileprivate func becomeFirstResponder(key: String) {
        if let indx = arrCell.firstIndex(where: { $0.key == key }) {
            if let cell = tblChangePassword.cellForRow(at: IndexPath(row: indx, section: 0)) as? TextCell {
                cell.txtField.becomeFirstResponder()
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
