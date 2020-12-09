//
//  CreateClubViewController.swift
//  UniEvents
//
//  Created by Yrua Riley on 12/9/20.
//

import UIKit

class CreateClubViewController: UIViewController {

  @IBOutlet weak var clubNameTextField: UITextField!
  @IBOutlet weak var clubDescriptionTextView: UITextView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    clubDescriptionTextView!.layer.borderWidth = 1
    
        // Do any additional setup after loading the view.
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
