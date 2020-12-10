//
//  CreateEventViewController.swift
//  UniEvents
//
//  Created by Joseph Miller on 12/2/20.
//

import UIKit
import Parse

class CreateEventViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.becomeFirstResponder()
        
        self.descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTextView.layer.borderWidth = 1
        self.descriptionTextView.layer.cornerRadius = 5.0
        
        // Do any additional setup after loading the view.
    }
    
    func createEvent() {
        let event = PFObject(className: "Event")
        event["title"] = titleTextField.text
        event["description"] = descriptionTextView.text
        event["startTime"] = startDatePicker.date
        event["endTime"] = endDatePicker.date
        event["host"] = PFUser.current()!
        event["location"] = locationTextField.text
        // TODO: Refactor code to get school so it can be accessed from different view controllers
        guard let school = PFUser.current()!["school"] as? PFObject else { return }
        do { try school.fetchIfNeeded() }
        catch { print("error getting school for event being created") }
        event["school"] = school
        event.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print("saved event \"\(event["title"] ?? "")\"")
            } else {
                print("error saving event")
            }
        }
    }
    
    @IBAction func onCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCreate(_ sender: UIButton) {
        // TODO: Create event in database
        createEvent()
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
