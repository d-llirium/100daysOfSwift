# [project 1-3 from 100 days of swift](https://www.hackingwithswift.com/100)
### resolution by d_llirium

![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project1-3/CloseAndShowIcon.gif?raw=true) ![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project1-3/ScrollDownTableView.gif?raw=true) ![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project1-3/SelectCell_OpenImage.gif?raw=true) ![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project1-3/ShareImage.gif?raw=true)


#### . [day 23 challenge](https://www.hackingwithswift.com/100/23)
1.  Start with a Single View App template, then change its main ViewController class so that builds on UITableViewController instead.
##### .. at ViewController
    class ViewController: UITableViewController {
2. Load the list of available flags from the app bundle. You can type them directly into the code if you want, but it’s preferable not to.
##### .. at ViewController
    //
    var flags = [String]()
    var countries = [String]()
    
    override func viewDidLoad() {
        //
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
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
    //
3. Create a new Cocoa Touch Class responsible for the detail view controller, and give it properties for its image view and the image to load.
##### .. at DetailViewController
    //
    @IBOutlet var imageView: UIImageView!
    var selectedFlag: String?
    var selectedCountry: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        if let countryFlag = selectedCountry {
            title = ".. \(countryFlag) flag"
            navigationItem.largeTitleDisplayMode = .never
        }
        if let imageToLoad = selectedFlag {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    //
4. You’ll also need to adjust your storyboard to include the detail view controller, including using Auto Layout to pin its image view correctly.
5. You will need to use UIActivityViewController to share your flag.
##### .. at ViewController
    //
    override func viewDidLoad() {
        //
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showTapped))
        //
    }
    //
    @objc func showTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8), let name = selectedCountry else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image, name], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    //
