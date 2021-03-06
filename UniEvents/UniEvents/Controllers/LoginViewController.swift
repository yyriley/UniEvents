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
    
    var user: PFUser!
    //    var userSchool: School!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // method to sign up throws an error if given an invalid parameter
    // save school to user defaults
    func signUp(email: String, password: String) throws {
        user = PFUser()
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
        var schoolShortName = emailComponents![1].components(separatedBy: ".edu")[0]
        let schoolComponents = schoolShortName.components(separatedBy: ".")
        schoolShortName = schoolComponents[schoolComponents.endIndex - 1]
        
        guard schoolShortName.count > 0 else {
            throw SignUpError.invalidSchoolName
        }
        // assign school to user using function in School.swift
        assignSchool(user: user, shortname: schoolShortName) { school in
            self.user["school"] = school
            let userSchool = School(school: school as! PFObject)
            saveSchool(school: userSchool)
            self.signUpInBackground(user: self.user)
        }
        let name = user["name"]!
        print("User \"\(name)\" is signing up at \"\(schoolShortName)\"")
    }
    
    func signUpInBackground(user: PFUser) {
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                let errorString = error.localizedDescription
                // Show the errorString somewhere and let the user try again.
                print(errorString)
            } else {
                print("User \(user.username!) signed up.")
                self.saveUser(user: user)
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    func saveUser(user: PFUser) {
        user.saveInBackground { (success: Bool, error: Error?) in
            if success { print("User saved") }
            else { print("Error saving user") }
        }
    }
    
    func login(email: String, password: String) {
        PFUser.logInWithUsername(inBackground:email, password:password) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                // After successful login
                // convert user school to from PFObject to School object
                // then save school to user defaults
                if let school = currentSchool() {
                    let currentSchool = School(school: school)
                    saveSchool(school: currentSchool)
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
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

