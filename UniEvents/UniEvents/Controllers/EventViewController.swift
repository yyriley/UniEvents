//
//  EventViewController.swift
//  UniEvents
//
//  Created by Joseph Miller on 12/11/20.
//

import UIKit

class EventViewController: UIViewController {
    
    let dateFormatter = DateFormatter()
    var event: Event?

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var clubNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do additional setup if passed an event
        guard let event = event else { return }
        dateFormatter.dateFormat = "MMM d, h:mm a"
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        locationLabel.text = event.location
        if let startTime = event.startTime {
            startTimeLabel.text = dateFormatter.string(from: startTime)
        }
        if let endTime = event.endTime {
            endTimeLabel.text = dateFormatter.string(from: endTime)
        }
        // TODO: Add "club" as optional column to event table as pointer to Club
        // Check if event has a club to show as host, default to user host
//        clubNameLabel.text = event.club?.name ?? event.host["name"] as? String
        let host = event.host
        do { try host.fetchIfNeeded() }
        catch { print("error getting host for event detail") }
        clubNameLabel.text = host["name"] as? String ?? ""
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
