//
//  ViewController.swift
//  PlannerApp
//
//  Created by Alexander Masztak on 3/8/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var saveEvents: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addEvent: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    let userDefaults = UserDefaults.standard
    var date2 = " "
    var plans = ["Quiz", "Homework"]
    var colors = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MM-dd"
        let dayNumber = dateFormatter2.string(from:date)
        date2 = String(dayNumber)
        dateLabel.text = dayInWeek + " " + dayNumber

        let strings: [String] = userDefaults.object(forKey: "plansArray") as? [String] ?? []
        plans = strings
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = plans[indexPath.row]
        let color = colors[indexPath.row]
        cell.backgroundColor = UIColor.init(named: color)
        return cell
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            plans.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
         //blank
    }
}
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 15

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 8    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    @IBAction func addToTable(_ sender: UIBarButtonItem) {
        let number = plans.count
//        if number > 9 {
//            addEvent.isEnabled = false
//        } else {
//            addEvent.isEnabled = true
//            if let newEvent = textField.text,
//               textField.text != "" {
//                plans.append(newEvent)
//                tableView.reloadData()
//                textField.text = ""
//            } else {
//                //error correction
//            }
//        }
    }
    
    @IBAction func pressSave(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(plans, forKey: "plansArray")
        let number = plans.count
        if number > 9 {
            addEvent.isEnabled = false
        } else {
            addEvent.isEnabled = true
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "segue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
        }
    }

