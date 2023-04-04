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
    
    @IBOutlet weak var imgViewBg: UIImageView!
    @IBOutlet weak var imgViewEpisode: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var slideerSeekbar: UISlider!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    //MARK: - Variables
    
    var episodeDetailsVM: EpisodeDetailsVM?

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
        bindViewModel()
    }
    
    fileprivate func bindViewModel() {
        episodeDetailsVM?.objWeek.bind({ [weak self] (week) in
            print("week --> ", week)
        })
        
        episodeDetailsVM?.objEpisode.bind({ [weak self] (episode) in
            self?.lblTitle.text = episode?.title ?? ""
            self?.lblDescription.text = episode?.description ?? ""
            self?.imgViewEpisode.image = (episode?.id ?? 0) % 2 == 0 ? #imageLiteral(resourceName: "svgWeek2") : #imageLiteral(resourceName: "svgWeek1") 
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
