# [project 1-3 from 100 days of swift](https://www.hackingwithswift.com/100)
#### . [day **__**](https://www.hackingwithswift.com/100/**__**)
#### . [day **__**](https://www.hackingwithswift.com/100/**__**)
##### .. TOPICS: 
... <>
... <>
... <FileManager>
... <typecasting>

##### .. IMPLEMENTATION:
1. **__**
2. **__**
3. **__**

![](**ScrollDownTableView.gif**)

### resolution by d_llirium
####  . [day **__** challenge](https://www.hackingwithswift.com/100/)
1.  Try loading the "Detail" view controller and typecasting it to be DetailViewController.
2. Set its selectedImage property.
3. Push it onto the navigation controller
##### .. at ViewController
//
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 
        if let dvc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            
            dvc.selectedFlag = countries[indexPath.row] + "@3x.png"
            dvc.selectedCountry = countries[indexPath.row]
            
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
//
![](**SelectCell_OpenImage.gif**)

####  . [day **__** challenge](https://www.hackingwithswift.com/100/)
1.  **__**
##### .. at DetailViewController
    //
    override func viewDidLoad() {{
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

![](**ShareImage.gif**)
