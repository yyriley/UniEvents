//
//  Club.swift
//  UniEvents
//
//  Created by Joseph Miller on 12/5/20.
//

import Foundation
import Parse

class Club {
    var name: String
    var school: School
    var email: String?
    var description: String?
    
    init(name: String, school: School, email: String?, description: String?) {
        self.name = name
        self.school = school
        self.email = email
        self.description = description
        
    }
    
    init(club: PFObject, school: School) {
        self.name = club["name"] as? String ?? ""
        self.school = school
        self.email = club["email"] as? String
        self.description = club["description"] as? String
    }
}

func createClubs() -> [Club]? {
    return nil
}

