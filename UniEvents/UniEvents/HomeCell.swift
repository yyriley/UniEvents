//
//  HomeCell.swift
//  UniEvents
//
//  Created by Yrua Riley on 11/27/20.
//

import UIKit

class HomeCell: UITableViewCell {

  @IBOutlet weak var location: UILabel!
  @IBOutlet weak var startTime: UILabel!
  @IBOutlet weak var eventName: UILabel!
  @IBOutlet weak var eventImage: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
