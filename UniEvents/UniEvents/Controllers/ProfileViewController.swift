//
//  ProfileViewController.swift
//  UniEvents
//
//  Created by Joseph Miller on 12/3/20.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let user = PFUser.current() else {
            print("No user is currently logged in.")
            return
        }
        usernameLabel.text = user["name"] as? String
        schoolLabel.text = loadSchool()?.name
//        guard let school = user["school"] as? PFObject else { return }
//        do { try school.fetchIfNeeded() }
//        catch { print("error getting school for user profile") }
//        schoolLabel.text = school["longName"] as? String ?? school["shortName"] as? String
    }
    
    @IBAction func onLogout(_ sender: UIButton) {
        if let user = PFUser.current() {
            print("\(user["name"] ?? "Unknown user") logging out")
            PFUser.logOut()
            // switch back to login scren
            let main = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate
            else {
                print("Scene Delegate not found")
                return
            }
            delegate.window?.rootViewController = loginViewController
        }
        print("Logged out")
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
