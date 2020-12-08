//
//  School.swift
//  UniEvents
//
//  Created by Joseph Miller on 12/3/20.
//

import Foundation
import Parse

class School {
    var shortName: String
    var longName: String?
    
    init(shortName: String) {
        self.shortName = shortName
    }
}

// create a new school Parse object
func newSchool(shortName: String, _ completion: ((_ school: Any?) -> ())? = nil) {
    let school = PFObject(className: "School")
    school["shortName"] = shortName
  
    school.saveInBackground { (success: Bool, error: Error?) in
        if success {
            print("saved school \"\(shortName)\"")
            // return schools in completion handler
            if let completion = completion {
                completion(school)
            }
        } else {
            print("error saving school")
        }
    }
}

// Find school in Parse database and assign to user
// If no school object is found in database, create a new school
// Optional completion handler to do something with the new school
func assignSchool(user: PFUser, shortname: String, _ completion: ((_ school: Any?) -> ())? = nil) {
    // make parse query to get school from user
    let schoolQuery = PFQuery(className: "School")
    schoolQuery.limit = 1
    schoolQuery.whereKey("shortName", equalTo: shortname)
    schoolQuery.findObjectsInBackground { (schools: [PFObject]?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
        } else if let schools = schools {
            let school: PFObject
            if schools.count == 0 {
                // Create school if not found in database
                newSchool(shortName: shortname, completion)
            } else {
                school = schools[0]
                // return school in completion handler
                if let completion = completion {
                    completion(school)
                }
            }
        }
    }
}
