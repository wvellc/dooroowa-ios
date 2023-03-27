//
//  MenuCell.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/27/23.
//

import UIKit

class MenuCell: UITableViewCell {

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
        
    }
    
    func configureData(indx: IndexPath, title: String, selected: String) {
        lblTitle.text = title
        viewBg.isHidden = selected != title
    }
    
}
