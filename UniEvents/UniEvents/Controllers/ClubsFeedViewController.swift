//
//  ClubsFeedViewController.swift
//  UniEvents
//
//  Created by Yrua Riley on 11/29/20.
//

import UIKit
import Parse

class ClubsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
  @IBOutlet var tableView: UITableView!
  
  var clubs = [PFObject]()
  

    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
  override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      self.loadClubs()
  }
  
  func loadClubs() {
      let query = PFQuery(className:"Club")
      query.limit = 20
      query.findObjectsInBackground { (events: [PFObject]?, error: Error?) in
         if let error = error {
            print(error.localizedDescription)
         } else if let clubs = clubs {
            print("Successfully retrieved \(clubs.count) events.")
          self.clubs = clubs
          self.tableView.reloadData()
         }
      }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return clubs.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell") as! ClubCell
    let club = clubs[indexPath.row]
    
    cell.clubName.text = club["name"] as? String
    cell.clubDescription.text = club["description"] as? String
    
    cell.clubImage.layer.cornerRadius = 20.0
  

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
