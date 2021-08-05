# [project 9 from 100 days of swift](https://www.hackingwithswift.com/100)
#### . [day 39](https://www.hackingwithswift.com/100/39)

##### .. TOPICS: 
...  

##### .. IMPLEMENTATION:
1. 


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
2. Let users filter the petitions they see. This involves creating a second array of filtered items that contains only petitions matching a string the user entered. Use a UIAlertController with a text field to let them enter that string. This is a tough one, so I’ve included some hints below if you get stuck.
##### .. at ViewController
    //
    override func viewDidLoad() {
        //
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(popSearch))
        //
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
    //
3. Experiment with the HTML – this isn’t a HTML or CSS tutorial, but you can find lots of resources online to give you enough knowledge to tinker with the layout a little.
##### .. at DetailViewController
    //
    override func viewDidLoad() {
        //
        let html = """
            <html>
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <style> body { font-size: 150%; } </style>
                </head>
                <body>
                    <header>
                        <h4>\(detailItem.title)</h4>
                    </header>
                    <p>
                        \(detailItem.body)
                    </p>
                    <footer>
                        <h6>\(detailItem.signatureCount)<h6>
                    </footer>
                </body>
            </html>
            """
        webView.loadHTMLString(html, baseURL: nil)
        //
        }
    //

