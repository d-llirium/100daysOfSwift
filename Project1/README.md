# [project 1 from 100 days of swift](https://www.hackingwithswift.com/100)
#### . [day 16](https://www.hackingwithswift.com/100/16)
#### . [day 17](https://www.hackingwithswift.com/100/17)
##### .. TOPICS: 
... table views
... image views
... app bundles
... FileManager
... typecasting
... view controllers
... storyboards
... outlets
... Auto Layout
... UIImage

##### .. IMPLEMENTATION:
1. Listing images with FileManager
2. Building a detail screen
3. Loading images with UIImage

### resolution by d_llirium
####  . day [18 challenge](https://www.hackingwithswift.com/100/18)
1.  Use Interface Builder to select the text label inside your table view cell and adjust its font size to something larger – experiment and see what looks good.
2. In your main table view, show the image names in sorted order, so “nssl0033.jpg” comes before “nssl0034.jpg”.
3. Rather than show image names in the detail title bar, show “Picture X of Y”, where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0.
##### .. at ViewController
//
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let dvc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
        
        dvc.selectedImage = pictures[indexPath.row]
        dvc.totalNumberOfPictures = pictures.count
        dvc.currentPictureIndex = indexPath.row + 1
        
        navigationController?.pushViewController(dvc, animated: true)
        }
    }
//

####  . day [22 challenge](https://www.hackingwithswift.com/100/22)
2. add a bar button item to the main view controller that recommends the app to other people.
##### .. at ViewController
//
    override func viewDidLoad() {
    //
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "<3", style: .plain, target: self, action: #selector(shareTapped))
    //
    }
    @objc func shareTapped() {
        guard let myApp = URL(string: "https://apps.apple.com/app/thisApp") else { return }
        let recommend = "I recommend"
        let vc = UIActivityViewController(activityItems: [recommend, myApp], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
//
![](**SelectCell_OpenPhoto.gif**)
![](**ShareRecommend_AddToReadingList_AppIcon.gif**)