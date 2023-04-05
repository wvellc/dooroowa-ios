//
//  ProfileVM.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/4/23.
//

import Foundation

protocol ProfileProtocol {
    var arrCells: Observable<[ProfileModel]> { get set }
}

class ProfileVM: NSObject, ProfileProtocol {

    //MARK: - Variables
    
    var arrCells: Observable<[ProfileModel]> = Observable([])
    
    override init() {
        /* Initial setup when view load */
        super.init()
        doInitialSettings()
    }
    
    deinit {
        print("Profile View Model released from memory")
    }

    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        fetchUserInfo()
    }
    
    func fetchUserInfo() {
        var arrTemp = [ProfileModel]()
        arrTemp.append(ProfileModel(title: "name".localized, placeholder: "John Doe", key: "name"))
        arrTemp.append(ProfileModel(title: "email_id_placeholder".localized, placeholder: "abc@xyz.com", key: "email"))
        arrTemp.append(ProfileModel(title: "phone_number".localized, placeholder: "+1234567890", key: "phone"))
        arrCells = Observable(arrTemp)
    }
}
