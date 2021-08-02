//
//  ViewController.swift
//  Project2
//
//  Created by user on 08/07/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adds these countries to the array
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        
        //day 22 - Challenge 3:  add a bar button item that shows their score when tapped.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "score", style: .plain ,target: self, action: #selector(showTapped))
        
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        //button1.setImage() assigns a UIImage to the button. We have the US flag in there right now, but this will change it when askQuestion() is called
        //for: .normal The setImage() method takes a second parameter that describes which state of the button should be changed. We're specifying .normal, which means "the standard state of the button."
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        //day 21 - Challenge 1: Try showing the player’s score in the navigation bar, alongside the flag to guess.
        title = "score = \(score) ...\(countries[correctAnswer].uppercased())"
    }
    //connected to the 3 buttons
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        }else{
            //When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
            title = "Wrong! that's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        //day 21 - Challenge 2: Keep track of how many questions have been asked, and show one final alert controller after they have answered 10. This should show their final score.
        if questionsAnswered < 9 {
            questionsAnswered += 1
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        } else {
            score = 0
            correctAnswer = 0
            questionsAnswered = 0
            ac.addAction(UIAlertAction(title: "retake the quiz", style: .destructive, handler: askQuestion))
        }
        present(ac,animated: true)
    }
    @objc func showTapped() {
        let ac = UIAlertController(title: "Your score is", message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "okay", style: .default))
        present(ac, animated: true)
    }
}

