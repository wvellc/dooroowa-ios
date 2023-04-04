//
//  SettingCell.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/4/23.
//

import UIKit

class SettingCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: - Variables
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - IBActions
    
    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        
        /* Setup view layout */
        viewBg.layer.borderColor = ColorsConst.AppBlue10?.cgColor
        viewBg.layer.borderWidth = 1
        viewBg.layer.cornerRadius = 10
    }
    
    func configureData(indx: IndexPath, title: String) {
        lblTitle.text = title.localized
    }
    
}
