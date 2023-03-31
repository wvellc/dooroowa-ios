//
//  WeekCell.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/30/23.
//

import UIKit
import SPPerspective

class WeekCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var lblWeekTitle: UILabel!
    @IBOutlet weak var viewWeek: UIView!
    @IBOutlet weak var imgViewBg: UIImageView!
    @IBOutlet weak var imgViewWeek: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    
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
    
    func configureData(indx: IndexPath, model: WeekModel?) {
        lblWeekTitle.text = model?.week ?? ""
        viewWeek.backgroundColor = indx.row % 2 == 0 ? ColorsConst.AppLightBlue : ColorsConst.AppLightBlue50
        imgViewWeek.image = indx.row % 2 == 0 ? #imageLiteral(resourceName: "svgWeek1") : #imageLiteral(resourceName: "svgWeek2")
    }
    
}
