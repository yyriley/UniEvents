//
//  HomeViewController.swift
//  UniEvents
//
//  Created by Yrua Riley on 11/25/20.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dateFormatter = DateFormatter()
    
    var user: PFUser?
    var school: PFObject?
    var events = [PFObject]()
    var selectedEvent: PFObject?
    
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.delegate = self
        
        guard PFUser.current() != nil else {
            return
        }
        user = PFUser.current()
        school = currentSchool()
        
        dateFormatter.dateFormat = "MMM d, h:mm a"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        self.title = self.school?["longName"] as? String ?? self.school?["shortName"] as? String ?? "?"
        self.loadEvents()
    }
    
    func loadEvents() {
        // make parse query to get event posts
        // then reload table view
        let query = PFQuery(className:"Event")
        query.limit = 20
        query.whereKey("school", equalTo: school ?? "")
        //        query.order(byDescending: "startTime")
        query.findObjectsInBackground { (events: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let events = events {
                print("Successfully retrieved \(events.count) events.")
                // TODO: Do something with events...
                self.events = events
                self.homeTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! EventCell
        let event = events[indexPath.row]
        
        cell.eventName.text = event["title"] as? String
        let host = event["host"] as! PFUser
        host.fetchIfNeededInBackground { (host, error) in
            if let error = error {
                let errorString = error.localizedDescription
                print(errorString)
            } else {
                cell.clubName.text = (host?["name"] as? String)?.capitalized
            }
        }
        cell.location.text = event["location"] as? String
        let startTime = event["startTime"] as? Date
        guard startTime != nil else {
            return cell
        }
        cell.startTime.text = dateFormatter.string(from: startTime!)
        // Make image view a circle by rounding corners (image width is set to 128)
        // currently the default image is already a circle, this will be useful later
        cell.eventImage.layer.cornerRadius = 20.0
        
        return cell
    }
    
    // MARK: - Navigation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // switch to event detail view controller programatically
        if let eventViewController = storyboard?.instantiateViewController(identifier: "EventViewController") as? EventViewController {
            eventViewController.event = Event(event: events[indexPath.row])
            navigationController?.pushViewController(eventViewController, animated: true)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("leaving home view")
    }
    
    
}
