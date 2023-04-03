//
//  EpisodeDetailsVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/3/23.
//

import UIKit

class EpisodeDetailsVC: UIViewController {

    static func instance() -> EpisodeDetailsVC {
       return EpisodeDetailsVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.episodes)
    }
    
    //MARK: - IBOutlets
    
    var episodeDetailsVM: EpisodeDetailsVM?
    
    //MARK: - Variables
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       
    }
    
    deinit {
        print("Episode details screen released from memory")
    }
    
    //MARK: - IBActions
    
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        AppConst.APPDELEGATE.setupNavigationAppearance(backgroundColor: .red)
        bindViewModel()
    }
    
    fileprivate func bindViewModel() {
        episodeDetailsVM?.objWeek.bind({ [weak self] (week) in
            print("week --> ", week)
        })
        
        episodeDetailsVM?.objEpisode.bind({ [weak self] (episode) in
            print("episode --> ", episode)
        })
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
