//
//  GameViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 2/19/23.
//

import UIKit

class GameViewController: UIViewController {
    
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var timer: Timer!
    let gameBrain = GameBrain.shared
    
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        print("\(sender.titleLabel?.text) button tapped")
        gameBrain.letterSelected(letter: (sender.titleLabel?.text)!)
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameBrain.newGame(numLetters: 12)
        updateUI()
        configureTimer()
        
        self.navigationItem.title = ""
        self.navigationItem.leftBarButtonItem =
        UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(addTapped))
        
    }
    
    @objc func addTapped(){
        print("Back nav item tapped")
        timer.invalidate()
        print("Dismiss - high score:\(gameBrain.highScore)")
        if let parent = self.presentingViewController {
                parent.viewWillAppear(true)
              }
        self.dismiss(animated: true)
    }
    	
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer.invalidate()
    }
    
    func updateUI() {
        targetLabel.text = "\(gameBrain.targetLetter)"
        scoreLabel.text = "Score: \(gameBrain.score)"
        secondsLabel.text = "Seconds: \(gameBrain.secondsRemaining)"
        
        var idx = 0
        for letter in letterButtons {
            let buttonLetter = gameBrain.randomLetters[idx]
            letter.setTitle(buttonLetter, for: .normal)
            if(buttonLetter == gameBrain.targetLetter){
                letter.backgroundColor = UIColor.red
            } else {
                letter.backgroundColor = UIColor.systemBlue
            }
            idx += 1
        }
        
    }
    
    func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: fireTimer(timer:))
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func fireTimer(timer: Timer) {
        gameBrain.secondsRemaining -= 1
        updateUI()
        print("fireTimer seconds remaining: \(gameBrain.secondsRemaining)")
        
        if gameBrain.secondsRemaining <= 0 {
            timer.invalidate()
            print("Dismiss - high score:\(gameBrain.highScore)")
            if let parent = self.presentingViewController {
                    parent.viewWillAppear(true)
                  } 
            self.dismiss(animated: true)
        }
    }
    
//    func newRound() {
//        updateTargetLetterLabel()
//        randomLetters = generateRandomLetters(numLetters: 12)
//        updateLetterButtons()
//        
//        
//    }
//    
//    func generateRandomLetters(numLetters: Int) -> [String] {
//        print("targetLetter:\(targetLetter)")
//        //return array
//        var retArr = [String]()
//        //indexes of letters array that have been used
//        var usedIdxs = [Int]()
//        //index of return array where the target letter
//        //will go
//        let targetIdx = Int.random(in: 0..<numLetters)
//        print("targetIdx:\(targetIdx)")
//        var i = 0
//        while i < numLetters {
//            let idx = Int.random(in: 0..<26)
//            if(usedIdxs.contains(idx) || letters[idx] == targetLetter){
//                print("Already used letter: \(letters[idx])")
//                continue
//            }
//            if(i == targetIdx){
//                retArr.append(targetLetter)
//                let targetLetterIdx = letters.firstIndex(where: {$0 == targetLetter})!
//                print("Inserting targetLetter \(targetLetter) at idx \(targetIdx)")
//                usedIdxs.append(targetLetterIdx)
//            } else {
//                print("Adding letter \(letters[idx])")
//                retArr.append(letters[idx])
//                usedIdxs.append(idx)
//            }
//            i += 1
//        }
//        return retArr
//    }
    
    func calculateNewScore(selectedLetter: String) {
//        if(selectedLetter == targetLetter){
//            score += 1
//        }
    }
    
}
