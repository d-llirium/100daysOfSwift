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

