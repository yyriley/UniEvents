//
//  Event.swift
//  UniEvents
//
//  Created by Joseph Miller on 12/3/20.
//

import Foundation
import Parse

class Event {
    var host: PFUser
    var school: School
    var title: String
    var description: String?
    var startTime: Date?
    var endTime: Date?
    var location: String?
    var club: Club?
    
    init(host: PFUser, school: School, name: String, description: String?, start: Date?, end: Date?, location: String?, club: Club?) {
        self.host = host
        self.school = school
        self.title = name
        self.description = description
        self.startTime = start
        self.endTime = end
        self.location = location
        self.club = club
    }
    
    init(event: PFObject) {
        self.host = event["host"] as! PFUser
//        self.school = School(school: event["school"] as! PFObject)
        self.school = loadSchool()!
        self.title = event["title"] as! String
        self.description = event["description"] as? String
        self.startTime = event["startTime"] as? Date
        self.endTime = event["endTime"] as? Date
        self.location = event["location"] as? String
    }
}
