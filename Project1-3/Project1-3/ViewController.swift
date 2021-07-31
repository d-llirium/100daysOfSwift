//
//  ViewController.swift
//  Project4
//
//  Created by user on 14/07/21.
//

import UIKit
//ATTENTION: - remember to change the name of the class that controls the table view controller for view controller
class ViewController: UITableViewController {
    
    //MARK: - Atributes
    var flags = [String]()
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = ". flag viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        //bundle = .app directories
        let path = Bundle.main.resourcePath!
        //The items constant will be an array of strings containing filenames
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items{
            if item.hasPrefix("AppIcon") {
            }
            else {
                if item.hasSuffix("@2x.png") {
                    //this is a flag to load
                    flags.append(item)
                    var country = item
                    country.removeLast(7)
                    countries.append(country)
                }
            }
        }
        print(flags)
    }
    
    //MARK: - UITableViewControlller
    //returns the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    //returns the content of each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //says the identifier of the cell is Flag for each indexPath from the "storyboard"
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        //the array of flags stores the name of the path
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        cell.textLabel?.text = countries[indexPath.row]

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let dvc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            dvc.selectedFlag = countries[indexPath.row] + "@3x.png"
            dvc.selectedCountry = countries[indexPath.row]
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

