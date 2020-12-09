//
//  ClubsFeedViewController.swift
//  UniEvents
//
//  Created by Yrua Riley on 11/29/20.
//

import UIKit

class ClubsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
  @IBOutlet var tableView: UITableView!
  
  
  

    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell") as! ClubCell

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
