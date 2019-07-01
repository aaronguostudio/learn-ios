//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var correctAnswer : Bool = false
    var questionIndex: Int = 0
    var score: Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
    }
    
    
    func updateUI() {
        scoreLabel.text = "\(score + 1)"
        progressLabel.text = "\(questionIndex + 1)/13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionIndex + 1)
        questionLabel.text = allQuestions.list[questionIndex].questionText;
        correctAnswer = allQuestions.list[questionIndex].answer;
    }
    

    func nextQuestion() {
        if questionIndex < allQuestions.list.count - 1 {
            questionIndex += 1
        }
        updateUI()
        if questionIndex >= allQuestions.list.count - 1 {
            let alert = UIAlertController(title: "Awesome", message: "You are done!", preferredStyle: .alert )
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {
                (UIAlertAction) in self.startOver()
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func checkAnswer() {
        if pickedAnswer == correctAnswer {
            ProgressHUD.showSuccess("Correct!")
            score += 1
            nextQuestion()
        } else {
            ProgressHUD.showError("Guess Again")
        }
    }
    
    
    func startOver() {
        questionIndex = 0
        score = 0
        updateUI()
    }
    

    
}
