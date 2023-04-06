//
//  EpisodesVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/3/23.
//

import UIKit
import Combine

class EpisodesVC: UIViewController {

    static func instance() -> EpisodesVC {
       return EpisodesVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.episodes)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblEpisodes: UITableView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    
    //MARK: - Variables
    
    var episodesVM: EpisodesVM?
    
    private var tblDataSource: TableViewDataSource<EpisodeCell,EpisodeModel>?
    private var tblDelegate: TableViewDelegate?
    private var arrEpisodes = [EpisodeModel]()
    private var cancellables = Set<AnyCancellable>()

    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        print("Episodes screen released from memory")
    }
    
    //MARK: - IBActions
    
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        title = "episodes".localized
        registerCell()
        bindViewModel()
        configureTableView()
    }
    
    /// Register table view cells
    fileprivate func registerCell() {
        /* Registering Xib (view/cell) to table view */
        tblEpisodes.register(UINib(nibName:"EpisodeCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
        /* Assigning empty view to footer view */
        tblEpisodes.tableFooterView = UIView()
        /* Reload table view */
        tblEpisodes.reloadData()
    }
    
    fileprivate func bindViewModel() {
        episodesVM?.objWeek.sink { [weak self] (week) in
            self?.lblHeaderTitle.text = week?.week ?? ""
        }.store(in: &cancellables)
        
        episodesVM?.arrEpisodes.sink { [weak self] (episodes) in
            self?.arrEpisodes = episodes
            self?.tblDataSource?.arrItems = self?.arrEpisodes
            self?.tblEpisodes.reloadData(delegate: self?.tblDelegate)
        }.store(in: &cancellables)
    }

    fileprivate func configureTableView() {
        //Table View DataSource
        self.tblDataSource = TableViewDataSource(identifier: "EpisodeCell", items: arrEpisodes, configureCell: { (cell, item, indexPath) in
            cell.configureData(indx: indexPath, model: item)
        })

        //Table View Delegate
        self.tblDelegate = TableViewDelegate()
        
        ///Table view selection action
        self.tblDelegate?.tblDidSelectRowAt = { [weak self] (indexPath) in
            let aEpisode = self?.arrEpisodes[indexPath.row]
            let aVC = EpisodeDetailsVC.instance()
            aVC.episodeDetailsVM = EpisodeDetailsVM(week: self?.episodesVM?.objWeek.value, episode: aEpisode)
            self?.navigationController?.pushViewController(aVC, animated: true)
        }
        
        //Reloading table view with animation after assigning delegate and data source
        DispatchQueue.main.async {
            self.tblEpisodes.delegate = self.tblDelegate
            self.tblEpisodes.dataSource = self.tblDataSource
            self.tblEpisodes.reloadDataWithAnimation(delegate: self.tblDelegate)
        }
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
