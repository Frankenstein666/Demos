//
//  ViewController.swift
//  ExpandTableCellDemo
//
//  Created by Arun on 4/25/16.
//  Copyright © 2016 Arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {

    @IBOutlet weak var expandTableView: UITableView!
    var selectedIndex = -1
    var dataArray : [[String:String]] = [["MatchName" : "First Match", "Team1" : "US", "Team2" : "Australia", "Score" : "Score 1-0"], ["MatchName" : "Second Match", "Team1" : "India", "Team2" : "Sri lanka", "Score" : "Score 2-0"], ["MatchName" : "Third Match", "Team1" : "West Indies", "Team2" : "South Africa", "Score" : "Score 2-4"], ["MatchName" : "Fourth Match", "Team1" : "New Zealand", "Team2" : "Holland", "Score" : "Score 0-0"] ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        expandTableView.estimatedRowHeight = 40
        expandTableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! customCell
        
        let obj = dataArray[indexPath.row]
        cell.matchName.text = obj["MatchName"]
        cell.team1.text = obj["Team1"]
        cell.team2.text = obj["Team2"]
        cell.score.text = obj["Score"]
        cell.firstViewBtn.tag = indexPath.row
        cell.secondViewBtn.tag = indexPath.row
        cell.delegate = self
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(selectedIndex == indexPath.row) {
            return 100;
        } else {
            return 40;
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    
    
    func updateTableView(row: Int) {
        if(selectedIndex == row) {
            selectedIndex = -1
        } else {
            selectedIndex = row
        }
        let path: NSIndexPath = NSIndexPath(row: row, section: 0)
        self.expandTableView.beginUpdates()
        self.expandTableView.reloadRows(at: [path as IndexPath], with: UITableViewRowAnimation.automatic )
        self.expandTableView.endUpdates()
    }
    
    func navigateToDetail(row: Int) {
        selectedIndex = row
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detail") {
            let detailController = segue.destination as! DetailScreenViewController
            let obj = dataArray[selectedIndex]
            detailController.setTeam1(t1: obj["Team1"]!)
            detailController.setTeam2(t2: obj["Team2"]!)
            detailController.setScore(sc: obj["Score"]!)
            
        }
    }
    
    /*
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(selectedIndex == indexPath.row) {
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
        }
        self.expandTableView.beginUpdates()
        self.expandTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic )
        self.expandTableView.endUpdates()
    }
   */
}

