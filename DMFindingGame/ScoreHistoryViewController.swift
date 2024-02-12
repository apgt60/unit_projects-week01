//
//  ScoreHistoryViewController.swift
//  DMFindingGame
//
//  Created by Amit Patel on 2/9/24.
//

import UIKit

class ScoreHistoryViewController: UITableViewController {
    
    var scoresArray = [Score]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoresArray = CoreDataManager.shared.fetchScores()

        print("viewDidLoad for ScoreHistoryViewController")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoresArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let score = scoresArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreHistoryCell", for: indexPath)
        cell.textLabel?.text = String(score.score)
        
        return cell
    }
    
}
