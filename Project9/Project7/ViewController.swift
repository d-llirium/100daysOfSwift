//
//  ViewController.swift
//  Project7
//
//  Created by user on 28/07/21.
//

import UIKit

class ViewController: UITableViewController {
    var allPetitions = [Petition]()
    let noPetitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //day 35 - Challenge 1: Add a Credits button to the top-right corner using UIBarButtonItem.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "credits", style: .plain, target: self, action: #selector(popCredit))
        
        //day 35 - Challenge 2: Let users filter the petitions they see. This involves creating a second array of filtered items that contains only petitions matching a string the user entered. Use a UIAlertController with a text field to let them enter that string. This is a tough one, so I’ve included some hints below if you get stuck.
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(popSearch))
        
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadPetitions))
        
        navigationItem.leftBarButtonItems = [refreshItem,searchItem]
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 { //the first instance of ViewController loads the original JSON
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json" //urlString accessing the available petitions.
        } else {//the second loads only petitions that have at least 10,000 signatures
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        DispatchQueue.global(qos: .userInitiated).async { //make all our loading code run in the background queue with user-initiated quality of service
            [weak self] in //make sure there aren’t any accident strong reference cycles
            if let url = URL(string: urlString){ //to make sure the URL is valid
                if let data = try? Data(contentsOf: url){//returns the content from a URL, but it might throw an error (i.e., if the internet connection was down) so we need to use try?.
                    self?.parse(json: data)
                    return
                }
            }
            self?.showError()
        }
    }
    func parse(json: Data) {
        let decoder = JSONDecoder()//creates an instance of JSONDecoder, which is dedicated to converting between JSON and Codable objects.
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {//calls the decode() method on that decoder, asking it to convert our json data into a Petitions object. This is a throwing call, so we use try? to check whether it worked.---Petitions.self, which is Swift’s way of referring to the Petitions type itself rather than an instance of it. That is, we’re not saying “create a new one”, but instead specifying it as a parameter to the decoding so JSONDecoder knows what to convert the JSON too.
            self.allPetitions = jsonPetitions.results//assign the results array to our petitions property
            self.filteredPetitions = allPetitions
            
            DispatchQueue.main.async {
                [weak self] in
                self?.tableView.reloadData()//reload the table view.
                
            }
        }
    }
    func showError(){ //creates a UIAlertController showing a general failure message
        DispatchQueue.main.async{
            [weak self] in
            let ac = UIAlertController(title: ". loading error", message: ".. there was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default))
            self?.present(ac, animated: true)
        }
        
    }
    @objc func popCredit(){
        let ac = UIAlertController(title: "credits", message: "the data from this app comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "got it!", style: .destructive, handler: nil)
        ac.addAction(closeAction)
        present(ac, animated: true)
    }
    @objc func popSearch(){
        let ac = UIAlertController(title: "Enter expression", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let searchButton = UIAlertAction(title: ".. seach", style: .default) { [weak self, weak ac] action in
                guard let searchWord = ac?.textFields?[0].text else { return }
                self?.searchFor(searchWord)
            }
            ac.addAction(searchButton)
            present(ac, animated: true)
        }
    func searchFor (_ searchWord: String) {
        if searchWord.isEmpty {
            self.reloadPetitions()
        }else {
            self.filteredPetitions = self.noPetitions
            for i in 0...self.allPetitions.count-1 {
                if allPetitions[i].title.contains(searchWord) || allPetitions[i].body.contains(searchWord) {
                    self.filteredPetitions.append(allPetitions[i])
                }
            }
        }
        tableView.reloadData()
    }
    @objc func reloadPetitions(){
        self.filteredPetitions = self.allPetitions
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //Previously we used the instantiateViewController() method to load a view controller from Main.storyboard, but in this project DetailViewController isn’t in the storyboard – it’s just a free-floating class. This makes didSelectRowAt easier, because it can load the class directly rather than loading the user interface from a storyboard.
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

