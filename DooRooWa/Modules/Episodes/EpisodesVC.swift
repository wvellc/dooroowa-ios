//
//  EpisodesVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/27/23.
//

import UIKit

class EpisodesVC: UIViewController {

    static func instance() -> EpisodesVC {
       return EpisodesVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.episodes)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblEpisodes: UITableView!
    
    //MARK: - Variables
    
    private var tblDataSource: TableViewDataSource<WeekCell,WeekModel>?
    private var tblDelegate: TableViewDelegate?
    private var episodesVM  = EpisodesVM()
    private var arrWeeks = [WeekModel]()
    
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
    
    
    @IBAction func btnMenuPressed(_ sender: UIBarButtonItem) {
        sideMenuController?.showLeftView()
    }
    
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
        tblEpisodes.register(UINib(nibName:"WeekCell" , bundle: nil), forCellReuseIdentifier: "WeekCell")
        /* Assigning empty view to footer view */
        tblEpisodes.tableFooterView = UIView()
        /* Reload table view */
        tblEpisodes.reloadData()
    }
    
    fileprivate func bindViewModel() {
        episodesVM.arrWeeks.bind { [weak self] (weeks) in
            self?.arrWeeks = weeks
            self?.tblDataSource?.arrItems = self?.arrWeeks
            self?.tblEpisodes.reloadData(delegate: self?.tblDelegate)
        }
    }

    fileprivate func configureTableView() {
        //Table View DataSource
        self.tblDataSource = TableViewDataSource(identifier: "WeekCell", items: arrWeeks, configureCell: { (cell, item, indexPath) in
            cell.configureData(indx: indexPath, model: item)
        })

        //Table View Delegate
        self.tblDelegate = TableViewDelegate()
        
        ///Table view selection action
        self.tblDelegate?.tblDidSelectRowAt = { [weak self] (indexPath) in
            guard let self else { return }
            print(indexPath, self)
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
