//
//  EpisodesVM.swift
//  DooRooWa
//
//  Created by Vision on 31/03/23.
//

import Foundation

protocol EpisodesProtocol {
    var objWeek: Observable<WeekModel?> { get set }
    var arrEpisodes: Observable<[EpisodeModel]> { get set }
}
final class EpisodesVM: NSObject, EpisodesProtocol {
    
    //MARK: - Variables
    
    var objWeek: Observable<WeekModel?>
    var arrEpisodes: Observable<[EpisodeModel]> = Observable([])
    
    init(week: WeekModel?) {
        objWeek = Observable(week)

        /* Initial setup when view load */
        super.init()
        doInitialSettings()
    }
    
    deinit {
        print("Episodes View Model released from memory")
    }

    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        fetchEpisodes()
    }
    
    func fetchEpisodes() {
        var arrTempWeeks = [EpisodeModel]()
        for indx in 1...3 {
            var week = EpisodeModel(id: indx, title: "Eliminate Stress", description: "Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci.", type: "video".localized, week: "\(objWeek.value?.week ?? "\("week".localized) 1")")
            arrTempWeeks.append(week)
            week = EpisodeModel(id: indx, title: "Detox The Mind", description: "Sed ipsum ipsum, ullamcorper tincidunt ligula et, dapibus tristique dui. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci.  Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci.", type: "audio".localized, week: "\(objWeek.value?.week ?? "\("week".localized) 1")")
            arrTempWeeks.append(week)
            week = EpisodeModel(id: indx, title: "Guided Imagery", description: "Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci.Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci. Sed sit amet velit fermentum, dictum eros non, efficitur mauris. Cras ut tempor orci.", type: "tool".localized, week: "\(objWeek.value?.week ?? "\("week".localized) 1")")
            arrTempWeeks.append(week)
        }
        arrEpisodes = Observable(arrTempWeeks)
    }
}
