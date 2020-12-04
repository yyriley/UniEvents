//
//  HomeViewController.swift
//  UniEvents
//
//  Created by Yrua Riley on 11/25/20.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        user = (UserDefaults.standard.object(forKey: "user") as? PFUser)
        school = (UserDefaults.standard.object(forKey: "school") as? PFObject)

        // Do any additional setup after loading the view.
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
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell

        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
