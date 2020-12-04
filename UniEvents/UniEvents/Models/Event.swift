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
    var title: String
    var description: String?
    var startTime: Date?
    var endTime: Date?
    
    init(host: User, school: School, title: String, description: String?, start: Date?, end: Date?) {
        self.host = host
        self.school = school
        self.title = title
        self.description = description
        self.startTime = start
        self.endTime = end
    }
}
