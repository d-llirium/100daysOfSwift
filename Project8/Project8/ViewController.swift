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
    
    var activatedButtons = [UIButton]() //buttons tapped by the user
    var solutions = [String]() //correct words
    
    var score = 0 {
        didSet {//add a property observer to our score property so that we update the score label whenever the score value was changed
            scoreLabel.text = "SCORE: \(score)"
        }
    }
    var levelSteps = 0
    
    var level = 1
    
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
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)//when Auto Layout has to decide which view to stretch they are first in line
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()//create the empty label
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)//when Auto Layout has to decide which view to stretch they are first in line
        view.addSubview(answersLabel)
        
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
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)//saying that the user pressed down on the button and lifted their touch while it was still inside. So, altogether that line means “when the user presses the submit button, call submitTapped() on the current view controller.”
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        let buttonsView = UIView()//UIView – it does nothing special other than host our buttons.
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
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
        
        let width = 150 //represents the width of the buttons
        let height = 80 //represents the height of the buttons
        
        for row in 0..<4 { //because we have 4 rows
            for column in 0..<5 {//because we have 5 columns
                let letterButton = UIButton(type: .system)//Create a new button
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)// with a nice and large font of 36
                letterButton.setTitle("WWW", for: .normal)// give the button some temporary text so we can see it on-screen
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * height, width: width - 5, height: height - 5)// calculate the frame of this button using its column and row -- Calculate the X position of the button as being our column number multiplied by the button width. AND Calculate the Y position of the button as being our row number multiplied by the button height. - 5 to put a small space beween them
                letterButton.frame = frame
                
                //day 38 - Challenge 1:Use the techniques you learned in project 2 to draw a thin gray line around the buttons view, to make it stand out from the rest of the UI.
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                letterButton.layer.cornerRadius = 8 //++round the edges
                letterButton.backgroundColor = .systemGray5
                
                buttonsView.addSubview(letterButton)//Add it to the buttonsView
                letterButtons.append(letterButton) //add the new button to the array of UIButtons
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLevel()
    }
    @objc func letterTapped(_ sender: UIButton){
        guard let buttonTitle = sender.titleLabel?.text else { return } //It adds a safety check to read the title from the tapped button, or exit if it didn’t have one for some reason.
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle) //Appends that button title to the player’s current answer.
        activatedButtons.append(sender)//Appends the button to the activatedButtons array
        sender.isHidden = true//Hides the button that was tapped.
    }
    @objc func submitTapped(_ sender: UIButton){
        guard let answerText = currentAnswer.text else { return }
        
        if let solutionPosition = solutions.firstIndex(of: answerText) { //use firstIndex(of:) to search through the solutions array for an item and, if it finds it, tells us its position
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n") //split text into an array
            splitAnswers?[solutionPosition] = answerText//change the answers label so that rather than saying "7 LETTERS" it says "HAUNTED", so they know which ones they have solved already.
            answersLabel.text = splitAnswers?.joined(separator: "\n")//makes an array into a single string, with each array element separated by the string specified in its parameter.
            
            currentAnswer.text = ""//clear the current answer text field
            score += 1//add one to the score
            //day 38 - Challenge 3:  Try making the game also deduct points if the player makes an incorrect guess. Think about how you can move to the next level – we can’t use a simple division remainder on the player’s score any more, because they might have lost some points.
            levelSteps += 1
            if levelSteps == 7 { 
                let ac = UIAlertController(title: ". well done!", message: ".. are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "... let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        } else {
            score -= 1
            //day 38 - Challenge: . If the user enters an incorrect guess, show an alert telling them they are wrong. You’ll need to extend the submitTapped() method so that if firstIndex(of:) failed to find the guess you show the alert.
            let ac = UIAlertController(title: "NOT THIS TIME", message: ".. clear and try it again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "one more time", style: .cancel))
            present(ac, animated: true)
        }
    }
    func levelUp(action: UIAlertAction){
        level += 1//Add 1 to level.
        
        solutions.removeAll(keepingCapacity: true)//Remove all items from the solutions array.
        loadLevel()//Call loadLevel() so that a new level file is loaded and shown.
        
        for button in letterButtons {
            button.isHidden = false
        }
    }
    @objc func clearTapped(_ sender: UIButton){
        currentAnswer.text = ""//removes the text from the current answer text field
        for button in activatedButtons {
            button.isHidden = false //unhides all the activated buttons
        }
        activatedButtons.removeAll()//removes all the items from the activatedButtons array
    }
    func loadLevel(){
        var clueString = ""//will store all the level's clues
        var solutionsString = ""//will store how many letters each answer is (in the same position as the clues)
        var letterBits = [String]()//is an array to store all letter groups: HA, UNT, ED, and so on.
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
            if let levelContents = try? String(contentsOf: levelFileURL){ //uses url(forResource:) and contentsOf to find and load the level string from our app bundle.
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()//The text is then split into an array by breaking on the \n character (that's line break, remember), then shuffled so that the game is a little different each time.
                
                for (index,line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")//we split each line up based on finding :, because each line has a colon and a space separating its letter groups from its clue
                    let answer = parts[0]//first part of the split line into answer
                    let clue = parts[1]//second part into clue
                    
                    clueString += "\(index+1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionsString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)//trimmingCharacters(in:)  removes any letters you specify from the start and end of a string. -- .whitespacesAndNewlines, which trims spaces, tabs and line breaks, and we need exactly that here because our clue string and solutions string will both end up with an extra line break
        answersLabel.text = solutionsString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterButtons.shuffle()
        
        if letterButtons.count == letterBits.count{
            for i in 0..<letterButtons.count {//Looping from 0 to 19 (inclusive) means we can use the i variable to set a button to a letter group.
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }

}

