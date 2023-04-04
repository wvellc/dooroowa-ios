//
//  ProfileVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/27/23.
//

import UIKit
import ViewAnimator

class ProfileVC: UIViewController {

    static func instance() -> ProfileVC {
       return ProfileVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.profile)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblProfile: UITableView!
    @IBOutlet weak var barBtnEdit: UIBarButtonItem!
    @IBOutlet weak var viewBtnUpdate: UIView!

    //MARK: - Variables
    
    var profileVM: ProfileVM?

    private var tblDataSource: TableViewDataSource<TextCell,ProfileModel>?
    private var tblDelegate: TableViewDelegate?
    private var userInfo: UserModel?
    private var arrCell = [ProfileModel]()
    private var isEditingOn: Bool = false
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        print("Profile screen released from memory")
    }
    
    //MARK: - IBActions
    
    @IBAction func btnMenuPressed(_ sender: UIBarButtonItem) {
        sideMenuController?.showLeftView()
    }
    
    @IBAction func btnEditProfile(_ sender: UIBarButtonItem) {
        if !isEditingOn {
            toggleEditMode()
        }
    }

    @IBAction func btnUpdateProfile(_ sender: UIButton) {
        if isEditingOn && isValid() {
            toggleEditMode()
            if let aData = JsonObjectManager().modelToJson(model: userInfo) {
                UserDefaults.shared.saveCustomObject(aData, key: .user)
            }
        }
    }
    
    @IBAction func txtDidChange(_ sender: CustomTextField) {
        let clrError = ColorsConst.PlaceholderError, clrPlaceholder = ColorsConst.Border
        let row = arrCell[sender.tag]
        switch row.key {
        case "name":
            userInfo?.name = sender.text
            sender.bottomBorderColor = (userInfo?.name ?? "").trim().count > 1 ? clrPlaceholder : clrError
            break
        case "email":
            userInfo?.email = sender.text
            sender.bottomBorderColor = Validator.isEmailAddress(userInfo?.email ?? "") ? clrPlaceholder : clrError
            break
        case "phone":
            userInfo?.phone = sender.text
            sender.bottomBorderColor = Validator.isPhoneNumber(userInfo?.phone ?? "") ? clrPlaceholder : clrError
            break
        default:
            break
        }
    }
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        title = "profile".localized

        if let data = UserDefaults.shared.retriveCustomObject(.user) as? Data,
           let user = try? JSONDecoder().decode(UserModel.self, from: data) {
            userInfo = user
        }
        profileVM = ProfileVM()
        registerCell()
        bindViewModel()
        configureTableView()
    }
    
    /// Register table view cells
    fileprivate func registerCell() {
        /* Registering Xib (view/cell) to table view */
        tblProfile.register(UINib(nibName:"TextCell", bundle: nil), forCellReuseIdentifier: "TextCell")

        /* Reload table view */
        tblProfile.reloadData()
    }
    
    fileprivate func bindViewModel() {
        profileVM?.arrCells.bind { [weak self] (cell) in
            self?.arrCell = cell
            self?.tblDataSource?.arrItems = self?.arrCell
            self?.tblProfile.reloadData(delegate: self?.tblDelegate)
        }
    }

    fileprivate func configureTableView() {
        //Table View DataSource
        self.tblDataSource = TableViewDataSource(identifier: "TextCell", items: arrCell, configureCell: { [weak self] (cell, item, indexPath) in
            cell.configureData(indx: indexPath, model: item, userInfo: self?.userInfo, isEditingOn: self?.isEditingOn ?? false)
            cell.txtField.addTarget(self, action: #selector(self?.txtDidChange(_:)), for: .editingChanged)
        })

        //Table View Delegate
        self.tblDelegate = TableViewDelegate()
        
        //Reloading table view with animation after assigning delegate and data source
        DispatchQueue.main.async {
            self.tblProfile.delegate = self.tblDelegate
            self.tblProfile.dataSource = self.tblDataSource
            self.tblProfile.reloadDataWithAnimation(delegate: self.tblDelegate)
        }
    }
    
    fileprivate func toggleEditMode() {
        view.endEditing(true)
        if isEditingOn {
            isEditingOn = !isEditingOn
            barBtnEdit.image = #imageLiteral(resourceName: "svgEdit")
            viewBtnUpdate.isHidden = true
            title = "profile".localized
        } else {
            title = "profile".localized
            isEditingOn = !isEditingOn
            barBtnEdit.image = nil
            viewBtnUpdate.isHidden = false
            viewBtnUpdate.animate(animations: [AnimationType.from(direction: .bottom, offset: 50), AnimationType.zoom(scale: 0.8)], delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3)
        }
        tblProfile.reloadData(delegate: tblDelegate)
    }
    
    /// Checking validation and returns true/false
    fileprivate func isValid() -> Bool {
        if (userInfo?.name ?? "").trim().count < 1 {
            becomeFirstResponder(key: "name")
            return false
        } else if !Validator.isEmailAddress(userInfo?.email ?? "") {
            becomeFirstResponder(key: "email")
            return false
        } else if !Validator.isPhoneNumber(userInfo?.phone ?? "") {
            becomeFirstResponder(key: "phone")
            return false
        }
        return true
    }
    
    fileprivate func becomeFirstResponder(key: String) {
        if let indx = arrCell.firstIndex(where: { $0.key == key }) {
            if let cell = tblProfile.cellForRow(at: IndexPath(row: indx, section: 0)) as? TextCell {
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
