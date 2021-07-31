//
//  DetailViewController.swift
//  Project7
//
//  Created by user on 29/07/21.
//

import UIKit
import WebKit //to work with WKWebView

class DetailViewController: UIViewController {
    var webView: WKWebView! //create the web view, we need to store it as a property so we can reference it later on
    var detailItem: Petition?

    override func loadView() { //loadView() gets called before viewDidLoad()
        webView = WKWebView() //create a new instance of Apple's WKWebView web browser component and assign it to the webView property
        view = webView//we make our view (the root view of the view controller) that web view.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //we can't just drop the petition text into the web view, because it will probably look tiny. -- tells iOS that the page fits mobile devices, and that we want the font size to be 150% of the standard font size. All that HTML will be combined with the body value from our petition, then sent to the web view.
        guard let detailItem = detailItem else { return } // unwraps detailItem into itself if it has a value, which makes sure we exit the method if for some reason we didn’t get any data passed into the detail view controller.
        //day 35 - Challenge 3: Experiment with the HTML – this isn’t a HTML or CSS tutorial, but you can find lots of resources online to give you enough knowledge to tinker with the layout a little.
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
        webView.loadHTMLString(html, baseURL: nil)//Swift string called html that contains everything needed to show the page, and that's passed in to the web view's loadHTMLString() method so that it gets loaded. -- This is different to the way we were loading HTML before, because we aren't using a website here, just some custom HTML.
    }
}
