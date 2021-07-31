//
//  ViewController.swift
//  Project5
//
//  Created by user on 20/07/21.
//day 27

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))//created a new UIBarButtonItem using the "add" system item, and configured it to run a method called promptForAnswer() when tapped
        
        //day 28. Challenge 3: Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") { //takes as its parameters the name of the file and its path extension, and returns a String? – i.e., you either get the path back or you get nil if it didn’t exist.
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")//Tell it what string you want to use as a separator (for us, that's \n), and you'll get back an array.
            }
        }
        if allWords.isEmpty { //allWords.count == 0
            allWords = ["silkworm"]
        }
        startGame()
    }
    @objc func startGame() {
        title = allWords.randomElement()//sets our view controller's title to be a random word in the array, which will be the word the player has to find.
        usedWords.removeAll(keepingCapacity: true)//removes all values from the usedWords array, which we'll be using to store the player's answers so far. We aren't adding anything to it right now, so removeAll() won't do anything just yet.
        tableView.reloadData()//calls the reloadData() method of tableView. That table view is given to us as a property because our ViewController class comes from UITableViewController, and calling reloadData() forces it to call numberOfRowsInSection again, as well as calling cellForRowAt repeatedly
    }
    //MARK: - UITableViewController
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    //MARK: - Navigation Item
    @objc func promptForAnswer() {//It needs to be called from a UIBarButtonItem action, so we must mark it @objc. Hopefully you’re starting to sense when this is needed, but don’t worry if you forget – Xcode will always complain loudly if @objc is required and not present!
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)//Creating a new UIAlertController
        ac.addTextField()//The addTextField() method just adds an editable text input field to the UIAlertController.
     
        let submitAction = UIAlertAction(title: "Submit", style: .default) { //We use trailing closure syntax to provide some code to run when the alert action is selected.
            [weak self, weak ac] _ in //That code will use self and ac so we declare them as being weak so that Swift won’t create a strong reference cycle. The closure expects to receive a UIAlertAction as its parameter, so we write that inside the opening brace.** Everything after in is the actual code of the closure.
                guard let answer = ac?.textFields?[0].text else { return } //added a single text field to the UIAlertController using its addTextField() method, and we now read out the value that was inserted
                self?.submit(answer)//calling the submit() method of our view controller -- the closure can't call submit() if it doesn't capture the view controller.
        }
     
        ac.addAction(submitAction)//The addAction() method is used to add a UIAlertAction to a UIAlertController.
        present(ac, animated: true)
    }
    func submit(_ answer: String) {// able to see it's going to take the answer the user entered and try it out in the game.
        let lowerAnswer = answer.lowercased()//all the starter words are lowercase, so when we check the player's answer we immediately lowercase it using its lowercased() method. This is stored in the lowerAnswer constant because we want to use it several times.
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) { //Only if all three statements are true (the word is possible, the word hasn't been used yet, and the word is a real word), does the main block of code execute
                    //day 28. Challenge BONUS: Once you’ve done those three, there’s a really subtle bug in our game and I’d like you to try finding and fixing it. To trigger the bug, look for a three-letter word in your starting word, and enter it with an uppercase letter. Once it appears in the table, try entering it again all lowercase – you’ll see it gets entered

                    usedWords.insert(lowerAnswer, at: 0)//insert the new word into our usedWords array at index 0 . means that the newest words will appear at the top of the table view.
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)//we insert a new row into the table view. -- using insertRows() lets us tell the table view that a new row has been placed at a specific place in the array so that it can animate the new cell appearing
                    
                    return
                } else {
                    showErrorMessage(title: "Word not recognized", message: "You can't just make them up, you know!")
                }
            } else {
                showErrorMessage(title: "Word alredy used", message: "Be more original!")
            }
        }else {
            guard let title = title else { return }
            showErrorMessage(title: "Word not possible", message: "You can't spell that word from the \(title.lowercased())!")
        }
    }
    
    func isPossible(word: String) -> Bool { //word is the answer given by the user
        guard var tempWord = title?.lowercased() else { return false } //gets the game word which is  the title of the view as well
        
        for letter in word {//checks each letter of the answer
            if let position = tempWord.firstIndex(of: letter) {// if it can match any letter from the title, get the position of its first instance
                tempWord.remove(at: position) //remove it from the game word
            } else {
                return false
            }
        }
        return true
    }
    func isOriginal(word: String) -> Bool {
        //day 28. Challenge 1: Disallow answers that are just our start word. , just compare the start word against their input word and return false if they are the same.
        guard let tempWord = title?.lowercased() else { return false } //gets the game word which is  the title of the view as well
        if word == tempWord { return false }
        return !usedWords.contains(word)
    }
    func isReal(word: String) -> Bool {
        //day 28. Challenge 1: Disallow answers that are shorter than three letters. For the three-letter check, the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters
        if word.count < 3 { return false }
        let checker = UITextChecker() //UITextChecker class that is designed to spot spelling errors, which makes it perfect for knowing if a given word is real or not
        let range = NSRange(location: 0, length: word.utf16.count)//Swift’s strings natively store international characters as individual characters, e.g. the letter “é” is stored as precisely that. However, UIKit was written in Objective-C before Swift’s strings came along, and it uses a different character system called UTF-16 – short for 16-bit Unicode Transformation Format – where the accent and the letter are stored separately.

        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    //day 28. Challenge 2: Refactor all the else statements we just added so that they call a new method called showErrorMessage(). This should accept an error message and a title, and do all the UIAlertController work from there.
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
}

