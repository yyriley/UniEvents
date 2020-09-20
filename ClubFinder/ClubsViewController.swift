//
//  ClubsViewController.swift
//  ClubFinder
//
//  Created by Yrua Riley on 9/20/20.
//  Copyright © 2020 yrua. All rights reserved.
//

import UIKit

class ClubsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


  
  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ClubsCell") as! ClubsCell
    
    cell.textLabel?.text = "Club Name"
    
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
