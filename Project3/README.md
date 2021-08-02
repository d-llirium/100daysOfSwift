# [project 3 from 100 days of swift](https://www.hackingwithswift.com/100)
#### . [day 22](https://www.hackingwithswift.com/100/22)
##### .. TOPICS: 
... UIBarButtonItem 
... UIActivityViewController

### resolution by d_llirium

![](https://github.com/d-llirium/100daysOfSwift/blob/main/Project3/ShareImage.gif?raw=true)

####  . [day 22 challenge](https://www.hackingwithswift.com/100/22)
1. Try adding the image name to the list of items that are shared. The activityItems parameter is an array, so you can add strings and other things freely. Note: Facebook won’t let you share text, but most other share options will.
##### .. at DetailViewController
    //
    override func viewDidLoad() {
        //
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        //
        }
    }
    //
    @objc func shareTapped() {
        //
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8), let imageName = selectedImage else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    //


