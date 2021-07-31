//
//  ViewController.swift
//  Project6b
//
//  Created by user on 23/07/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()//creates a UILabel object
        label1.translatesAutoresizingMaskIntoConstraints = false // because by default iOS generates Auto Layout constraints for you based on a view's size and position. We'll be doing it by hand, so we need to disable this feature.
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()//because our labels are placed in their default position (at the top-left of the screen) and are all sized to fit their content thanks to us calling sizeToFit() on each of them
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1)//get added to the view belonging to our view controller by using view.addSubview()
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        let viewsDictionary = ["label1":label1, "label2":label2, "label3":label3, "label4":label4, "label5":label5] //creates a dictionary with strings for its keys and our labels as its values (the values). So, to get access to label1, we can now use viewsDictionary["label1"]
//
//        for labelKey in viewsDictionary.keys {//view.addConstraints(): this adds an array of constraints to our view controller's view
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(labelKey)]|", options: [], metrics: nil, views: viewsDictionary))//NSLayoutConstraint.constraints(withVisualFormat:) is the Auto Layout method that converts Visual Format Language into an array of constraints -- "H:|[label1]|". As you can see it's a string that  describes how we want the layout to look. = "horizontally, I want my label1 to go edge to edge in my view." > The H: parts means that we're defining a horizontal layout;  The pipe symbol, |, means "the edge of the view."  We're adding these constraints to the main view inside our view controller, so this effectively means "the edge of the view controller."
//        }
//        let metrics = ["labelHeight": 88]
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary)) //V: these constraints are vertical;> () height  > the - symbol, which means "space" (It's 10 points by default, but you can customize it.) > (>=10) for the space to the bottom > @ means priority 0...1000
        var previousLabel: UILabel?
        for label in [label1, label2, label3, label4, label5] {//That loops over each of the five labels
//            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true //have the same width as our main view
            //day 31. Challenge 1: Try replacing the widthAnchor of our labels with leadingAnchor and trailingAnchor constraints, which more explicitly pin the label to the edges of its parent
            //day 31. Challenge 2: Once you’ve completed the first challenge, try using the safeAreaLayoutGuide for those constraints. You can see if this is working by rotating to landscape, because the labels won’t go under the safe area.
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true //have the same width as our main view
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true //have the same width as our main view

            //day 31. Challenge 3: Try making the height of your labels equal to 1/5th of the main view, minus 10 for the spacing. This is a hard one, but I’ve included hints below!
//            label.heightAnchor.constraint(equalToConstant: 88 ).isActive = true//have a height of exactly 88 points.
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
            
            if let previous = previousLabel{
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true // if we have a previous label – create a height constraint
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true//push the first label away from the top of the safe area, so it doesn’t sit under the notch
            }
            previousLabel = label // set the previous label to be the current one, for the next loop iteration
        }
    }
}

