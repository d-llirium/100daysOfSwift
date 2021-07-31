//
//  ViewController.swift
//  Project1
//
//  Created by user on 05/07/21.
//

import UIKit

class ViewController: UITableViewController {
    //atributes
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ". storm viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        //bundle = .app directories
        let path = Bundle.main.resourcePath!
        //The items constant will be an array of strings containing filenames
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items{
            if item.hasPrefix("nssl"){
                //this is a picture to load
                pictures.append(item)
            }
        }
        pictures = pictures.sorted()
        print(pictures)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //says the identifier of the cell is Picture for each indexPath from the "storyboard"
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        //the array of pics stores the name of the path
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //day 22 - Challenge 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let dvc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            //day 22 - Challenge 2: success! Set its selectedImage property
            dvc.selectedImage = pictures[indexPath.row]
            dvc.totalNumberOfPictures = pictures.count
            dvc.currentPictureIndex = indexPath.row + 1
            //day 22 - Challenge 3: now push it onto the navigation controller
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

