//
//  DetailViewController.swift
//  Project4
//
//  Created by user on 14/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedFlag: String?
    var selectedCountry: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adds a bar button item that shows their score when tapped.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showTapped))
        
        if let countryFlag = selectedCountry {
            title = ".. \(countryFlag) flag"
            navigationItem.largeTitleDisplayMode = .never
        }
        if let imageToLoad = selectedFlag {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func showTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8), let name = selectedCountry else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image, name], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
