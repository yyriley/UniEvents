//
//  School.swift
//  UniEvents
//
//  Created by Joseph Miller on 12/3/20.
//

import Foundation
import Parse

struct School: Codable {
    var shortName: String
    var longName: String?
    var name: String {
        return longName ?? shortName
    }
    
    init(shortName: String) {
        self.shortName = shortName
    }
    
    init(school: PFObject) {
        self.shortName = school["shortName"] as? String ?? ""
        self.longName = school["longName"] as? String
    }
}

// save school to user defaults
func saveSchool(school: School) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(school) {
        UserDefaults.standard.set(encoded, forKey: "UserSchool")
        print("Saved school \(school.name) to user defaults")
    }
}

// return school saved to user defaults
// return nil if no school is saved
func loadSchool() -> School? {
    let decoder = JSONDecoder()
    if let school = UserDefaults.standard.object(forKey: "UserSchool") as? Data {
        if let loadedSchool = try? decoder.decode(School.self, from: school) {
            print("loaded saved school \(loadedSchool.name)")
            return loadedSchool
        }
    }
    print("No saved school")
    return nil
}

// return school for current user
func currentSchool() -> PFObject? {
    let user = PFUser.current()!
    guard let school = user["school"] as? PFObject else { return nil }
    do { try school.fetchIfNeeded() }
    catch { print("error getting current school") }
    return school
}

// create a new school Parse object
func createNewSchool(shortName: String, _ completion: ((_ school: PFObject?) -> ())? = nil) {
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
                // then return school in completion handler
                createNewSchool(shortName: shortname, completion)
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
