//
//  SideMenuVM.swift
//  DooRooWa
//
//  Created by Vision on 31/03/23.
//

import Foundation
import Combine


class SideMenuVM: NSObject {
    
    //MARK: - Variables
    var arrMenu = CurrentValueSubject<[String], Never>([])
    
    override init() {
        super.init()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        print("Side Menu View Model released from memory")
    }

    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        arrMenu.send(["home", "episodes", "tools", "tests", "profile", "settings"])
    }
    
    func removeLast() {
        arrMenu.value.removeLast()
    }
}
