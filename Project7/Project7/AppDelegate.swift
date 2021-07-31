//
//  AppDelegate.swift
//  Project7
//
//  Created by user on 28/07/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //MARK: - Create a ViewController using code
        let sd = SceneDelegate()
        if let tabBarController = sd.window?.rootViewController as? UITabBarController {//for us the root view controller is a UITabBarController. -- the ViewController in embedded  inside a navigation controller, then embedded that inside a tab bar controller.
            let storyboard = UIStoryboard(name: "Main", bundle: nil) //create a new ViewController by hand, which first means getting a reference to our Main.storyboard file. -- You don't need to provide a bundle, because nil means "use my current app bundle."
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController") //create our view controller using the instantiateViewController() method, passing in the storyboard ID of the view controller we want.
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1) //create a UITabBarItem object for the new view controller, giving it the "Top Rated" icon and the tag 1 -- because it's an easy way to identify it
            tabBarController.viewControllers?.append(vc) // the new view controller to our tab bar controller's viewControllers array, which will cause it to appear in the tab bar.
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

