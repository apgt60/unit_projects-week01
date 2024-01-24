//
//  GameBrain.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/17/23.
//

import Foundation

class GameBrain {
    
    var targetLetter = ""
    var randomLetters = [String]()
    var score = 0
    var highScore = 0
    var numLetters = 0
    var secondsRemaining = 0
    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
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
                let idx = Int.random(in: 0..<26)//TODO: use letters.count
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
        print("returning array length=\(retArr.count) numLetters=\(numLetters)")
            return retArr
        }
    
    func newRound() {
        let idx = Int.random(in: 1..<letters.count)
        targetLetter = letters[idx]
        randomLetters = generateRandomLetters(numLetters: numLetters)
    }
    
    func newGame(numLetters: Int) {
        self.numLetters = numLetters
        score = 0
        secondsRemaining = 5
        newRound()
    }
    
    func letterSelected(letter: String){
        if( letter == targetLetter){
            score += 1
        }
        if(score > highScore){
            highScore = score
        }
        newRound()
    }
    
    
    
    
    static let shared = GameBrain()
}
