//
//  WebPageViewController.swift
//  Project4
//
//  Created by user on 19/07/21.
//

import UIKit
import WebKit//WKWebView. It’s part of the WebKit framework rather than the UIKit framework, but we can import it by adding this line

class WebPageViewController: UIViewController, WKNavigationDelegate {//create a new subclass of UIViewController called ViewController, and tell the compiler that we promise we’re safe to use as a WKNavigationDelegate
    
    var webView: WKWebView!
    var selectedUrl: URL?
    var progressView: UIProgressView! //will show how far the page is through loading
    var allowedSites: [String]!
    
    override func loadView() {
        webView = WKWebView()//create a new instance of Apple's WKWebView web browser component and assign it to the webView property
        webView.navigationDelegate = self//when any web page navigation happens, please tell me – the current view controller
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let selectedUrl = selectedUrl else { return }
        webView.load(URLRequest(url: selectedUrl)) //creates a new URLRequest object from that URL, and gives it to our web view to load.
        webView.allowsBackForwardNavigationGestures = true//enables a property on the web view that allows users to swipe from the left or right edge to move backward or forward in their web browsing
        
        let backButton = UIBarButtonItem(title: "<", style: .plain, target: webView, action: #selector(webView.goBack))
        progressView = UIProgressView(progressViewStyle: .default)//creates a new UIProgressView instance, giving it the default style
        progressView.sizeToFit()//tells the progress view to set its layout size so that it fits its contents fully.
        let progressButton = UIBarButtonItem(customView: progressView)//creates a new UIBarButtonItem using the customView parameter, which is where we wrap up our UIProgressView in a UIBarButtonItem so that it can go into our toolbar.
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //creating a new bar button item using the special system item type .flexibleSpace, which creates a flexible space. It doesn't need a target or action because it can't be tapped
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload)) //  it's calling the reload() method on the web view
        let forwardButton = UIBarButtonItem(title: ">", style: .plain, target: webView, action: #selector(webView.goForward))
        //day 26 - Challenge 2: Try making two new toolbar items with the titles Back and Forward. You should make them use webView.goBack and webView.goForward
        toolbarItems = [backButton, progressButton, spacer, refresh, forwardButton] //creates an array containing a progress view first, then a flexible space in the center and the refresh button on the right, then sets it to be our view controller's toolbarItems array
        navigationController?.isToolbarHidden = false //sets the navigation controller's isToolbarHidden property to be false, so the toolbar will be shown – and its items will be loaded from our current view.
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)//use Key-Value Observing. addObserver() method takes four parameters: who the observer is (we're the observer, so we use self), what property we want to observe (we want the estimatedProgress property of WKWebView) -- specify a path: one property inside another, inside another, and so on --, which value we want (we want the value that was just set, so we want the new one), and a context value
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { //called when the webPage finishes loading its page
        title = webView.title //update our view controller's title property to be the title of the web view, which will automatically be set to the page title of the web page that was most recently loaded
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) { //tells you when an observed value has changed -- which key path was changed, and it also sends us back the context we registered earlier so you can check whether this callback is for you or not
        if keyPath == "estimatedProgress" {// if the estimatedProgress value of the web view has changed.
            progressView.progress = Float(webView.estimatedProgress)//And if it has, we set the progress property of our progress view to the new estimatedProgress value
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
    //delegate callback allows us to decide whether we want to allow navigation to happen or not every time something happens
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url //set the constant url to be equal to the URL of the navigation
        if let host = url?.host { //use if let syntax to unwrap the value of the optional url.host -- website domain -- unwrap this carefully because not all URLs have hosts
        for website in allowedSites { // loop through all sites in our safe list, placing the name of the site in the website variable.
            if host.contains(website) { //contains() String method to see whether each safe website exists somewhere in the host name
                decisionHandler(.allow) //if the website was found then we call the decision handler with a positive response - we want to allow loading
                return //if the website was found, after calling the decisionHandler we use the return statement. This means "exit the method now."
            }
        }
            //day 24 - Challenge 1 : If users try to visit a URL that isn’t allowed, show an alert saying it’s blocked.
            let ac = UIAlertController(title: url?.absoluteString,message: "Its access is blocked.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "cancel loading", style: .destructive, handler: nil))
            present(ac,animated: true)
        }
        decisionHandler(.cancel) //if there is no host set, or if we've gone through all the loop and found nothing, we call the decision handler with a negative response: cancel loading
    }
}
