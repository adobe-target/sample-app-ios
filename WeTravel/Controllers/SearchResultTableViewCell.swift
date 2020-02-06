//
//  SearchResultTableViewCell.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topPrentView: UIView!
    @IBOutlet weak var imgRedioButton: UIImageView!
    @IBOutlet weak var lblRatingCount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblBusDetailTimeSeatStop: UILabel!
    @IBOutlet weak var lblTravelName: UILabel!
    @IBOutlet weak var lblDiscontOffer: UILabel!
    @IBOutlet weak var busInfo: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
