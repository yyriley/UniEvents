//
//  CreateClubViewController.swift
//  UniEvents
//
//  Created by Yrua Riley on 12/9/20.
//

import UIKit
import Parse

class CreateClubViewController: UIViewController {
    
    @IBOutlet weak var clubNameTextField: UITextField!
    @IBOutlet weak var clubDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubNameTextField.becomeFirstResponder()
        clubDescriptionTextView!.layer.borderWidth = 1
        
        // Do any additional setup after loading the view.
    }
    
    func createClub() {
        let club = PFObject(className: "Club")
        club["name"] = clubNameTextField.text
        club["description"] = clubDescriptionTextView.text
        // TODO: create "school" column for "Club" table that is a pointer to a "School" object
        club["school"] = currentSchool()
        
        club.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print("saved event \"\(club["name"] ?? "")\"")
            } else {
                print("error creating club")
            }
        }
    }
    
    @IBAction func onCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onCreate(_ sender: UIButton) {
        createClub()
        self.dismiss(animated: true, completion: nil)
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
