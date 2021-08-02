//
//  ViewController.swift
//  Project8
//
//  Created by user on 02/08/21.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    override func loadView() {//creates our user interface in code
        view = UIView()//UIView is the parent class of all of UIKit’s view types: labels, buttons, progress views, and more
        view.backgroundColor = .white //create the main view itself as a big and white empty space
        
        //MARK: - SCORE Label properties
        scoreLabel = UILabel() //create the empty label
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right //set the label’s textAlignment property so the text is right-aligned.
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        
        NSLayoutConstraint.activate([//accepts an array of constraints
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor), //view.layoutMarginsGuide – that will make the label have a little distance from the edge of the screen
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)//trailing = right for us
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

