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
        configureTableViewDelegates()
        updateDataSource()
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
    
    fileprivate func configureTableViewDelegates() {
        self.tblDelegate = TableViewDelegate()
        self.tblEpisodes.delegate = self.tblDelegate
        self.tblDelegate?.tblDidSelectRowAt = { [weak self] (indexPath) in
            guard let self else { return }
            print(indexPath)
        }
        
//        self.tblDelegate?.tblWillDisplayCellRowAt = { (cell, indexPath) in
//            if let cell = cell as? WeekCell {
////                cell.layer.transform = CATransform3DMakeScale(0.5,0.5,1)
////                UIView.animate(withDuration: 0.3, animations: {
////                    cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
////                },completion: { finished in
////                    UIView.animate(withDuration: 0.1, animations: {
////                        cell.layer.transform = CATransform3DMakeScale(1,1,1)
////                    })
////                })
//            }
//        }
    }
    
    fileprivate func updateDataSource() {
        var arrWeeks = [WeekModel]()
        for indx in 1...10 {
            let week = WeekModel(id: indx, week: "Week \(indx)")
            arrWeeks.append(week)
        }
        self.tblDataSource = TableViewDataSource(identifier: "WeekCell", items: arrWeeks, configureCell: { (cell, item, indexPath) in
            cell.configureData(indx: indexPath, model: item)
        })
        
        DispatchQueue.main.async {
            self.tblEpisodes.dataSource = self.tblDataSource
            self.tblEpisodes.reloadData()
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
