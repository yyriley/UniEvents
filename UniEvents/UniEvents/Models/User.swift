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
    var image: FILE
    
    init(username: String, school: School, name: String?, email: String?, image:FILE) {
        self.username = username
        self.school = school
        self.name = name
        self.email = email
        self.image = image
    }
}
