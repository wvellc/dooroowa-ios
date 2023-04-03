//
//  EpisodeCell.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/3/23.
//

import UIKit

class EpisodeCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var viewType: UIView!
    @IBOutlet weak var imgViewBg: UIImageView!
    @IBOutlet weak var imgViewEpisode: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
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
    
    func configureData(indx: IndexPath, model: EpisodeModel?) {
        lblTitle.text = model?.title ?? ""
        lblDescription.text = model?.description ?? ""
        lblType.text = model?.type ?? ""
        viewBg.backgroundColor = indx.row % 2 == 0 ? ColorsConst.AppLightBlue : ColorsConst.AppLightBlue50
        imgViewEpisode.image = indx.row % 2 == 0 ? #imageLiteral(resourceName: "svgWeek1") : #imageLiteral(resourceName: "svgWeek2")
    }
    
}
