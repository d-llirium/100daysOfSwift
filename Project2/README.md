# [project 2 from 100 days of swift](https://www.hackingwithswift.com/100)
#### . [day 19](https://www.hackingwithswift.com/100/19)
#### . [day 20](https://www.hackingwithswift.com/100/20)
##### .. TOPICS: 
... Interface Builder
... Auto Layout
... outlets 
... @2x and @3x images
... asset catalogs
... UIButton
... CALayer
... UIColor
... random numbers
... actions
... UIAlertController

### resolution by d_llirium

![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project2/PlaySelectFlag_ShowCorrectAnswer.gif?raw=true) ![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project2/ShowCurrentScore.gif?raw=true) ![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project2/FinalPlay_RetakeQuiz.gif?raw=true)

####  . [day 21 challenge](https://www.hackingwithswift.com/100/21)
1. Try showing the player’s score in the navigation bar, alongside the flag to guess.
##### .. at ViewController
    //
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "score = \(score) ...\(countries[correctAnswer].uppercased())"
    }
    //
2. Keep track of how many questions have been asked, and show one final alert controller after they have answered 10. This should show their final score.
##### .. at ViewController
    //
    @IBAction func buttonTapped(_ sender: UIButton) {
        //
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
    //
3. When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
##### .. at ViewController
    //
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        }else{
            title = "Wrong! that's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        //
        present(ac,animated: true)
        }
    //
####  . [day 22 challenge](https://www.hackingwithswift.com/100/22)
3. add a bar button item that shows their score when tapped.
##### .. at ViewController
    //
    override func viewDidLoad() {
        //
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "score", style: .plain ,target: self, action: #selector(showTapped))
        //
    }
    @objc func showTapped() {
        let ac = UIAlertController(title: "Your score is", message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "okay", style: .default))
        present(ac, animated: true)
    }
    //


