//
//  EpisodeDetailsVM.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/3/23.
//

import Foundation

protocol EpisodeDetailsProtocol {
    var objWeek: Observable<WeekModel?> { get set }
    var objEpisode: Observable<EpisodeModel?> { get set }
}
final class EpisodeDetailsVM: NSObject, EpisodeDetailsProtocol {
    
    //MARK: - Variables
    
    var objWeek: Observable<WeekModel?>
    var objEpisode: Observable<EpisodeModel?>
    
    init(week: WeekModel?, episode: EpisodeModel?) {
        objWeek = Observable(week)
        objEpisode = Observable(episode)

        /* Initial setup when view load */
        super.init()
        doInitialSettings()
    }
    
    deinit {
        print("Episodes Deatils View Model released from memory")
    }

    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {

    }
}
