//
//  ScoresViewController.swift
//  DMFindingGame
//
//  Created by Amit Patel on 2/12/24.
//

import UIKit

class ScoresViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var scoresArray = [Score]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        scoresArray = CoreDataManager.shared.fetchScores()
        print("viewDidLoad for ScoresViewController")
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        print("close button pressed")
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
    
}

extension ScoresViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let score = scoresArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoresCell", for: indexPath)
        cell.textLabel?.text = String(score.score)
        
        return cell
    }
    
}
