//
//  ClubCell.swift
//  UniEvents
//
//  Created by Yrua Riley on 12/8/20.
//

import UIKit

class ClubCell: UITableViewCell {
  
  @IBOutlet weak var clubName: UILabel!
  @IBOutlet weak var clubDescription: UILabel!
  @IBOutlet weak var clubImage: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
