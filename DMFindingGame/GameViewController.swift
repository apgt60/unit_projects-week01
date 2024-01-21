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
    
    @IBOutlet var letterButtons: [UIButton]!
    
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        print("Tapped \(sender.currentTitle!)")
        print("targetLetter:\(targetLetter)")
        if(sender.currentTitle! == targetLetter){
            updateScoreLabel()
        } else {
            print("no match")
        }
        newRound()
    }
    
    var targetLetter = ""
    var randomLetters = [String]()
    var score = 0
    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound() {
        updateTargetLetterLabel()
        randomLetters = generateRandomLetters(numLetters: 12)
        updateLetterButtons()
        
        
    }
    
    func generateRandomLetters(numLetters: Int) -> [String] {
        print("targetLetter:\(targetLetter)")
        //return array
        var retArr = [String]()
        //indexes of letters array that have been used
        var usedIdxs = [Int]()
        //index of return array where the target letter
        //will go
        let targetIdx = Int.random(in: 0..<numLetters)
        print("targetIdx:\(targetIdx)")
        var i = 0
        while i < numLetters {
            let idx = Int.random(in: 0..<26)
            if(usedIdxs.contains(idx) || letters[idx] == targetLetter){
                print("Already used letter: \(letters[idx])")
                continue
            }
            if(i == targetIdx){
                retArr.append(targetLetter)
                let targetLetterIdx = letters.firstIndex(where: {$0 == targetLetter})!
                print("Inserting targetLetter \(targetLetter) at idx \(targetIdx)")
                usedIdxs.append(targetLetterIdx)
            } else {
                print("Adding letter \(letters[idx])")
                retArr.append(letters[idx])
                usedIdxs.append(idx)
            }
            i += 1
        }
        return retArr
    }
    
    func calculateNewScore(selectedLetter: String) {
        if(selectedLetter == targetLetter){
            score += 1
        }
    }
    
    func updateTargetLetterLabel() {
        let idx = Int.random(in: 1..<26)
        targetLetter = letters[idx]
        targetLabel.text = targetLetter
    }
    
    func updateScoreLabel() {
        score += 1
        scoreLabel.text = String(score)
    }
    
    func updateLetterButtons() {
        var idx = 0
        for letter in letterButtons{
            letter.setTitle(randomLetters[idx], for: .normal)
            idx += 1
        }
    }
}
