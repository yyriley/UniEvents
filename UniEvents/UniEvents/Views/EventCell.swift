//
//  HomeCell.swift
//  UniEvents
//
//  Created by Yrua Riley on 11/27/20.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var savedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        savedLabel.text = ""
    }
    
}
