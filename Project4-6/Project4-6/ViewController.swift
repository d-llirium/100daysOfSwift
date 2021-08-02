//
//  ViewController.swift
//  Project4-6
//
//  Created by user on 27/07/21.
//

import UIKit

class ViewController: UITableViewController {
    //MARK: - Atributes
    var shoppingList = [String]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ". shopping list"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startList))
    }
    
    //MARK: - Methods
    @objc func startList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    //MARK: - UITableViewController
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopItem", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    //MARK: - Navigation Item
    @objc func promptForItem() {
        let ac = UIAlertController(title: "enter item", message: nil, preferredStyle: .alert)
        ac.addTextField()
     
        let submitAction = UIAlertAction(title: "submit", style: .default) {
            [weak self, weak ac] _ in
                guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ item: String){
        self.shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

