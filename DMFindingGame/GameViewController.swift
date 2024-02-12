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
        print("Filemanager stuff...")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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
        
        print("viewDidDisappear - Store - Current score: \(gameBrain.score)")
        CoreDataManager.shared.addScore(score: gameBrain.score)
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
            navigationController?.popViewController(animated: true)
        }
    }
    
}
