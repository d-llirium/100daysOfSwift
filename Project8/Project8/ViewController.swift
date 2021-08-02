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
        
        //MARK: - UI Elements and properties
        scoreLabel = UILabel() //create the empty label
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right //set the label’s textAlignment property so the text is right-aligned.
        scoreLabel.text = "SCORE: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel() //create the empty label
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24) //font property describes what kind of text font is used to render the label, and is provided as a dedicated type that describes a font face and size: UIFont. -- 24-point font in whatever font is currently being used by iOS
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0//numberOfLines is an integer that sets how many lines the text can wrap over, but we’re going to set it to 0 – a magic value that means “as many lines as it takes.”
        view.addSubview(cluesLabel)
        cluesLabel.backgroundColor = .red
        
        answersLabel = UILabel()//create the empty label
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        view.addSubview(answersLabel)
        answersLabel.backgroundColor = .blue
        
        currentAnswer = UITextField() //create an empty text field
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "tap letters to guess..."
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false //user can't type into the textnox
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        view.addSubview(clear)
        
        let buttonsView = UIView()//UIView – it does nothing special other than host our buttons.
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        buttonsView.backgroundColor = .green
        
        //MARK: - AUTOLAYOUT CONSTRAINTS
        NSLayoutConstraint.activate([//accepts an array of constraints
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor), //view.layoutMarginsGuide – that will make the label have a little distance from the edge of the screen
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),//trailing = right for us
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),// pin the top of the clues label to the bottom of the score label
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),// pin the leading (left) edge of the clues label to the leading edge of our layout margins, adding 100 for some space
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),// make the clues label 60% of the width of our layout margins, minus 100
            
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),// also pin the top of the answers label to the bottom of the score label
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),// make the answers label stick to the trailing edge of our layout margins, minus 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),// make the answers label take up 40% of the available space, minus 100
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),// make the answers label match the height of the clues label
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),//make this text field centered in our view
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),//make the width 50% of the view's width
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),//place it below the clues label, with 20 points of spacing so the two don’t touch.
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),//vertical position use the bottom of the current answer text field
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),//horizontally in our main view. To stop them overlapping, we’ll subtract 100 from the submit button’s X position
            submit.heightAnchor.constraint(equalToConstant: 44),//height of 44 points
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),//horizontally in our main view. To stop them overlapping, we’ll add 100 to the clear button’s X position.
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),//vertical position setting its Y anchor so that its stays aligned with the Y position of the submit button
            clear.heightAnchor.constraint(equalToConstant: 44),//height of 44 points
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),//width and height of 750x320 so that it precisely contains the buttons inside it.
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),//centered horizontally
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),//its top anchor to be the bottom of the submit button, plus 20 points to add a little spacing.
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)//pin it to the bottom of our layout margins, -20 so that it doesn’t run quite to the edge
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

