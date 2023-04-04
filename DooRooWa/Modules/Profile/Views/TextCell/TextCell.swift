//
//  TextCell.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/4/23.
//

import UIKit

class TextCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var lblTitle: LocalizableLabel!
    @IBOutlet weak var txtField: CustomTextField!

    //MARK: - Variables
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - IBActions
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        
        /* Setup view layout */
        
    }
    
    func configureData(indx: IndexPath, model: ProfileModel?, userInfo: UserModel?, isEditingOn: Bool) {
        lblTitle.text = model?.title ?? ""
        txtField.placeholder = model?.placeholder ?? ""
        txtField.isEnabled = isEditingOn
        txtField.tag = indx.row
        switch model?.key {
        case "name":
            txtField.keyboardType = .default
            txtField.textContentType = .name
            txtField.text = userInfo?.name ?? ""
            break
        case "email":
            txtField.keyboardType = .emailAddress
            txtField.textContentType = .emailAddress
            txtField.text = userInfo?.email ?? ""
            txtField.isEnabled = false
            break
        case "phone":
            txtField.keyboardType = .numberPad
            txtField.textContentType = .telephoneNumber
            txtField.text = userInfo?.phone ?? ""
            break
        default:
            txtField.keyboardType = .default
            txtField.textContentType = .none
            txtField.text = ""
            break
        }
    }
    
}
