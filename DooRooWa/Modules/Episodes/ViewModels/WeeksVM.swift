//
//  WeeksVM.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/3/23.
//

import Foundation

protocol WeeksProtocol {
    var arrWeeks: Observable<[WeekModel]> { get set }
}

final class WeeksVM: NSObject, WeeksProtocol {

    //MARK: - Variables
    
    var arrWeeks: Observable<[WeekModel]> = Observable([])
    
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
            let week = WeekModel(id: indx, week: "Week \(indx)")
            arrTempWeeks.append(week)
        }
        arrWeeks = Observable(arrTempWeeks)
    }
}
