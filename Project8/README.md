# [project 8 from 100 days of swift](https://www.hackingwithswift.com/100)
#### . [day 36](https://www.hackingwithswift.com/100/36)
#### . [day 37](https://www.hackingwithswift.com/100/37)
##### .. TOPICS: 
...  UIBUTTON.addTarget()
... ARRAY.enumerated()
... ARRAY.joined()
... STRING.replacingOccurrences()

##### .. IMPLEMENTATION:
1. Building a UIKit user interface programmatically
2. Adding button targets

### resolution by d_llirium

![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project8/SbmittingCorrectAnswers.gif?raw=true) ![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project8/SbmittingWrongAnswer.gif?raw=true) ![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project8/GoingNextLevel.gif?raw=true)


####  . [day 38 challenge](https://www.hackingwithswift.com/100/38)
1.  Use the techniques you learned in project 2 to draw a thin gray line around the buttons view, to make it stand out from the rest of the UI.
##### .. at ViewController
    //
    NSLayoutConstraint.activate(
        //
        for row in 0..<4 { //because we have 4 rows
            for column in 0..<5 {//because we have 5 columns
                // 
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                letterButton.layer.cornerRadius = 8 // ++ round the edges
                letterButton.backgroundColor = .systemGray5
                //
                }
            }
        }
    //
2. If the user enters an incorrect guess, show an alert telling them they are wrong. You’ll need to extend the submitTapped() method so that if firstIndex(of:) failed to find the guess you show the alert.
##### .. at ViewController
        //
        @objc func submitTapped(_ sender: UIButton){
            guard let answerText = currentAnswer.text else { return }
            
            if let solutionPosition = solutions.firstIndex(of: answerText) { //use firstIndex(of:) to search through the solutions array for an item and, if it finds it, tells us its position
                //
                }
            } else {
                let ac = UIAlertController(title: "NOT THIS TIME", message: ".. clear and try it again", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "one more time", style: .cancel))
                present(ac, animated: true)
            }
        }
        //    
3. Try making the game also deduct points if the player makes an incorrect guess. Think about how you can move to the next level – we can’t use a simple division remainder on the player’s score any more, because they might have lost some points.
##### .. at ViewController
        //
        var levelSteps = 0
        //
        @objc func submitTapped(_ sender: UIButton){
            guard let answerText = currentAnswer.text else { return }
            
            if let solutionPosition = solutions.firstIndex(of: answerText) { //use firstIndex(of:) to search through the solutions array for an item and, if it finds it, tells us its position
                //
                score += 1
                
                levelSteps += 1
                if levelSteps == 7 { 
                    //
                }
            } else {
                score -= 1
                //
            }
        }
        //

####  . [day 40 challenge](https://www.hackingwithswift.com/100/40)
2.  Modify project 8 so that loading and parsing a level takes place in the background. Once you’re done, make sure you update the UI on the main thread!
##### .. at ViewController
    //
        var clueString = ""
        var solutionsString = ""
        var letterBits = [String]()
        //
        override func viewDidLoad() {
            
            performSelector(inBackground: #selector(loadLevel), with: nil)
        }
        //
        func levelUp(action: UIAlertAction){
            level += 1
            solutions.removeAll(keepingCapacity: true)
            
            performSelector(inBackground: #selector(loadLevel), with: nil)
            
            for button in letterButtons {
                button.isHidden = false
            }
        }
        //
        @objc func loadLevel(){
            
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
            performSelector(onMainThread: #selector(createLabels), with: nil, waitUntilDone: false)
        }
        @objc func createLabels(){
            cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)//trimmingCharacters(in:)  removes any letters you specify from the start and end of a string. -- .whitespacesAndNewlines, which trims spaces, tabs and line breaks, and we need exactly that here because our clue string and solutions string will both end up with an extra line break
            answersLabel.text = solutionsString.trimmingCharacters(in: .whitespacesAndNewlines)
            
            letterButtons.shuffle()
            
            if letterButtons.count == letterBits.count{
                for i in 0..<letterButtons.count {//Looping from 0 to 19 (inclusive) means we can use the i variable to set a button to a letter group.
                    letterButtons[i].setTitle(letterBits[i], for: .normal)
                }
            }
        }
    
    //
