//
//  ControlsTableViewCell.swift
//  Exercise v3
//  Simple populated/fired controls from storyboard
//  Created by Deepson Khadka on 1/29/20.
//

import UIKit

class ControlsTableViewCell: UITableViewCell {
    @IBOutlet weak var listingLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var btnCell: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
