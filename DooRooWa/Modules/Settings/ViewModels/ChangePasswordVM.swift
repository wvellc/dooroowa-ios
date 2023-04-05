//
//  ChangePasswordVM.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/5/23.
//

import Foundation

protocol ChangePasswordProtocal {
    var arrCells: Observable<[ProfileModel]> { get set }
}

class ChangePasswordVM: NSObject, ChangePasswordProtocal {
    //MARK: - Variables
    
    var arrCells: Observable<[ProfileModel]> = Observable([])
    
    override init() {
        /* Initial setup when view load */
        super.init()
        doInitialSettings()
    }
    
    deinit {
        print("Change Password View Model released from memory")
    }

    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        prepareCells()
    }
    
    func prepareCells() {
        var arrTemp = [ProfileModel]()
        arrTemp.append(ProfileModel(title: "old_password".localized, placeholder: "• • • • • •", key: "old_password"))
        arrTemp.append(ProfileModel(title: "new_password".localized, placeholder: "• • • • • •", key: "new_password"))
        arrTemp.append(ProfileModel(title: "confirm_password".localized, placeholder: "• • • • • •", key: "confirm_password"))
        arrCells = Observable(arrTemp)
    }
}
