//
//  Club.swift
//  UniEvents
//
//  Created by Joseph Miller on 12/5/20.
//

import Foundation

class Club {
    var name: String
    var school: School
    var email: String?
    
    init(name: String, school: School, email: String?) {
        self.name = name
        self.school = school
        self.email = email
    }
}

func createClubs() -> [Club]? {
    return nil
}
