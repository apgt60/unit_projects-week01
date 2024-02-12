//
//  CoreDataManager.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/24/23.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Main")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    /**
     Add the passed score to CoreData.
     */
    func addScore(score: Int) {
        let newScore = Score(context: persistentContainer.viewContext)
        newScore.score = Int16(score)
        do{
            try  persistentContainer.viewContext.save()
        } catch {
            print("could not save new score")
        }
    }
    
    /**
     Retrieve all the scores from CoreData.
     */
    func fetchScores() -> [Score] {
        let request = Score.fetchRequest()
       // var scores = [Score]()
        do {
            return  try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
        return []
    }
    
    /**
     Calculate the high score.
     */
    func calculateHighScore() -> Int {
        let scoreObjs = fetchScores()
        let scores = scoreObjs.map{$0.score}
        return scores.count == 0 ? 0 : Int(scores.max()!)
    }
}
