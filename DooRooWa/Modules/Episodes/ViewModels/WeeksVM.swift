//
//  WeeksVM.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/3/23.
//

import Foundation
import Combine

final class WeeksVM: NSObject {

    //MARK: - Variables
    
    var arrWeeks = CurrentValueSubject<[WeekModel], Never>([])
    
    override init() {
        super.init()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        print("Episodes View Model released from memory")
    }

    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        fetchWeeks()
    }
    
    func fetchWeeks() {
        var arrTempWeeks = [WeekModel]()
        for indx in 1...10 {
            let week = WeekModel(id: indx, week: "\("week".localized) \(indx)")
            arrTempWeeks.append(week)
        }
        arrWeeks.send(arrTempWeeks)
    }
}
