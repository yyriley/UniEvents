//
//  ClubsCell.swift
//  ClubFinder
//
//  Created by Yrua Riley on 9/20/20.
//  Copyright © 2020 yrua. All rights reserved.
//

import UIKit

class ClubsCell: UITableViewCell {
  
  
  @IBOutlet var clubLabel: UILabel!
  @IBOutlet var clubDescriptionLabel: UILabel!
  @IBOutlet var clubPicView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
