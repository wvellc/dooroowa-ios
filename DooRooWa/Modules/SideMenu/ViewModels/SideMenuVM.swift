//
//  SideMenuVM.swift
//  DooRooWa
//
//  Created by Vision on 31/03/23.
//

import Foundation

protocol SideMenuProtocol {
    var arrMenu: Observable<[String]> { get set }
}
class SideMenuVM: NSObject, SideMenuProtocol {
    
    //MARK: - Variables
    var arrMenu: Observable<[String]> = Observable([])
    
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
        arrMenu = Observable(["home", "episodes", "tools", "tests", "profile", "settings"])
    }
    
    func removeLast() {
        arrMenu.value.removeLast()
    }
}
