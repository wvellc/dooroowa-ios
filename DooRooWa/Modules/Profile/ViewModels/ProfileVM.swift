//
//  ProfileVM.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/4/23.
//

import Foundation
import Combine

class ProfileVM: NSObject {

    //MARK: - Variables
    
    var arrCells = CurrentValueSubject<[ProfileModel], Never>([])
    
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
        arrCells.send(arrTemp)
    }
}
