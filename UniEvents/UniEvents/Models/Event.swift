//
//  Event.swift
//  UniEvents
//
//  Created by Joseph Miller on 12/3/20.
//

import Foundation

class Event {
    var host: User
    var school: School
    var name: String
    var description: String?
    var startTime: Date?
    var endTime: Date?
    var club: Club?
    
    init(host: User, school: School, name: String, description: String?, start: Date?, end: Date?, club: Club?) {
        self.host = host
        self.school = school
        self.name = name
        self.description = description
        self.startTime = start
        self.endTime = end
    }
}
