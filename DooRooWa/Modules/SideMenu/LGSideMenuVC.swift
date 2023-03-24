//
//  LGSideMenuVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/24/23.
//

import UIKit
import LGSideMenuController

class LGSideMenuVC: LGSideMenuController {

    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        print("LGSideMenu screen released from memory")
    }
    
    //MARK: - IBActions
    
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        leftViewPresentationStyle = .slideAbove
        leftViewLayerShadowColor = .clear
        rootViewCoverBlurEffectForLeftView = UIBlurEffect(style: .dark)
        rootViewCoverAlpha = 0.95
//        rootViewCoverColorForLeftView = ColorsConst.AppBlack50 ?? .clear
    }

}
