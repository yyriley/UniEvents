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
func newSchool(user: PFUser) -> PFObject {
    let shortName = user["school"]
    let school = PFObject(className: "School")
    school["shortName"] = shortName
    return school
}

// Find school in Parse database and assign to user
// If no school object is found in database, create a new school
// Optional completion handler to do something with the new school
func assignSchool(user: PFUser, shortname: String, _ completion: ((_ school: Any?) -> ())?) {
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
                school = newSchool(user: user)
            } else {
                school = schools[0]
            }
            // return schools in completion handler
            if let completion = completion {
                completion(school)
            }
        }
    }
}
