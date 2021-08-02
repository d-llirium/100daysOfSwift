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
        
        //MARK: - CLUES Label properties
        cluesLabel = UILabel() //create the empty label
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24) //font property describes what kind of text font is used to render the label, and is provided as a dedicated type that describes a font face and size: UIFont. -- 24-point font in whatever font is currently being used by iOS
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0//numberOfLines is an integer that sets how many lines the text can wrap over, but we’re going to set it to 0 – a magic value that means “as many lines as it takes.”
        view.addSubview(cluesLabel)
        
        //MARK: - ANSWERS Label properties
        answersLabel = UILabel()//create the empty label
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        view.addSubview(answersLabel)
        
        NSLayoutConstraint.activate([//accepts an array of constraints
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor), //view.layoutMarginsGuide – that will make the label have a little distance from the edge of the screen
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),//trailing = right for us
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),// pin the top of the clues label to the bottom of the score label
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),// pin the leading (left) edge of the clues label to the leading edge of our layout margins, adding 100 for some space
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),// make the clues label 60% of the width of our layout margins, minus 100
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),// also pin the top of the answers label to the bottom of the score label
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),// make the answers label stick to the trailing edge of our layout margins, minus 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),// make the answers label take up 40% of the available space, minus 100
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor)// make the answers label match the height of the clues label
            
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

