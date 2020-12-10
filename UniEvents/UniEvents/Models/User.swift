//
//  User.swift
//  UniEvents
//
//  Created by Joseph Miller on 12/3/20.
//

import Foundation
import Parse

class User {
    var username: String
    var school: School
    var name: String?
    var email: String?
    
    init(username: String, school: School, name: String?, email: String?) {
        self.username = username
        self.school = school
        self.name = name
        self.email = email
    }
}
