//
//  ClubViewController.swift
//  UniEvents
//
//  Created by Yrua Riley on 11/29/20.
//

import UIKit

class ClubViewController: UIViewController {
    
    var club: Club?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // print(club)
        nameLabel.text = club?.name
        descriptionLabel.text = club?.description
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
