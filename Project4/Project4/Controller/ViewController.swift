//
//  ViewController.swift
//  Project4
//
//  Created by user on 15/07/21.
// MARK: - day 24, 25
import UIKit

class ViewController: UITableViewController { //create a new subclass of UITableViewController called ViewController

    let websites = ["apple.com", "hackingwithswift.com"] //an array containing the websites we want the user to be able to visit
    var listOfSites = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ". simple browser"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        for website in websites {
            let url = "https://" + website
            listOfSites.append(url)
        }
        print(listOfSites)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))//lock this app down so that it opens websites selected by the user giving the user the option to choose from one of our selected websites, and that means adding a button to the navigation bar
        
    }
    //MARK: - TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return websites.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath) //says the identifier of the cell is Website for each indexPath from the "storyboard"
        cell.textLabel?.text = websites[indexPath.row] //the array of websites stores the name of the cell
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let wpvc = storyboard?.instantiateViewController(identifier: "WebPage") as? WebPageViewController { // try loading the "WebPage" view controller and typecasting it to be WebPageViewController
            print("WPVC okay :" + listOfSites[indexPath.row])
            wpvc.selectedUrl = URL(string: listOfSites[indexPath.row])
            wpvc.allowedSites = websites
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(wpvc, animated: true)
            print("WPVC loadadooooo")
        }
    }

//    @objc func openTapped(){ //Apple’s own Objective-C code in UIBarButtonItem, so the method must be marked @objc.
//        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet) //nil for the message, because this alert doesn't need one and the preferredStyle of .actionSheet because we're prompting the user for more information.
//        for website in websites{
//            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage)) //add one UIAlertAction object for each item in our array
//        }
//
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))//adding a dedicated Cancel button using style .cancel. It doesn’t provide a handler parameter, which means iOS will just dismiss the alert controller if it’s tapped
//        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem //on iPad, and tells iOS where it should make the action sheet be anchored.
//        present(ac, animated: true)
//    }
 
    
    


}

