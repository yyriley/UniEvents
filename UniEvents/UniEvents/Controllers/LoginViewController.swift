//
//  ViewController.swift
//  UniEvents
//
//  Created by Yrua Riley on 11/20/20.
//

import UIKit
import Parse

enum SignUpError: Error {
    case invalidEmail
    case invalidSchoolEmail
    case invalidUsername
    case invalidSchoolName
    case invalidPassword
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // method to sign up throws an error if given an invalid parameter
    func signUp(email: String, password: String) throws {
        let user = PFUser()
        user.password = password
        user.email = email
        user.username = email
        // Ensure an email address has been entered
        let emailComponents = emailField.text?.components(separatedBy: "@")
        guard emailComponents != nil && emailComponents!.count == 2 else {
            throw SignUpError.invalidEmail
        }
        // other fields (can be set just like with PFObject)
        // get username from first part of email (before the @)
        user["name"] = emailComponents![0]
        guard user["name"] != nil && (user["name"] as! String).count > 0 else {
            throw SignUpError.invalidUsername
        }
        // get school from second part of email (before the ".edu")
        // if multiple components to email second half (seperated by .) use the last
        var school = emailComponents![1].components(separatedBy: ".edu")[0]
        let schoolComponents = school.components(separatedBy: ".")
        school = schoolComponents[schoolComponents.endIndex - 1]
        user["school"] = school
        guard user["school"] != nil else {
            throw SignUpError.invalidSchoolName
        }
        print("User \"\(user.username!)\" is signing up at \"\(user["school"]!)\"")

        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                let errorString = error.localizedDescription
                // Show the errorString somewhere and let the user try again.
                print(errorString)
            } else {
                // TODO: Navigate to home view
                print("User \(user.username!) signed up.")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    func login(email: String, password: String) {
        PFUser.logInWithUsername(inBackground:email, password:password) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                // The login failed. Check error to see why.
                let errorString = error!.localizedDescription
                print(errorString)
            }
        }
    }

    @IBAction func onSignUp(_ sender: UIButton) {
        let password = passwordField.text!
        let email = emailField.text!
        do {
            try signUp(email: email, password: password)
        } catch SignUpError.invalidEmail {
            print("Invalid email")
        } catch SignUpError.invalidSchoolEmail {
            print("Not a valid school email")
        } catch SignUpError.invalidUsername {
            print("Invalid username")
        } catch SignUpError.invalidSchoolName {
            print("Invalid school name")
        } catch SignUpError.invalidPassword {
            print("Invalid password")
        } catch {
            print("Unknown error")
        }
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        let email = emailField.text!
        let password = passwordField.text!
        login(email: email, password: password)
    }
    
}

