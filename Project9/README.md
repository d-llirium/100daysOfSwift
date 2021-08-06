# [project 9 from 100 days of swift](https://www.hackingwithswift.com/100)
#### . [day 39](https://www.hackingwithswift.com/100/39)

##### .. IMPLEMENTATION:
1. Grand Central Dispatch (CGD)
  - automatically handles thread creation and management, 
  - automatically balances based on available system resources and
  - automatically factors in Quality of Service to ensure your code runs as efficiently as possible.


### resolution by d_llirium

![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project7/CreditButton.gif?raw=true) ![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project7/ShowDetailViewControllerWithHTML.gif?raw=true) ![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project7/SearchForPresident_FilterTableView.gif?raw=true)

####  . [day 35 challenge](https://www.hackingwithswift.com/100/35)
1. Add a Credits button to the top-right corner using UIBarButtonItem. When this is tapped, show an alert telling users the data comes from the We The People API of the Whitehouse.
##### .. at ViewController
    //
    override func viewDidLoad() {
        //
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "credits", style: .plain, target: self, action: #selector(popCredit))
        //
        }
    @objc func popCredit(){
        let ac = UIAlertController(title: "credits", message: "the data from this app comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "got it!", style: .destructive, handler: nil)
        ac.addAction(closeAction)
        present(ac, animated: true)
        }
    //


