//
//  AppDelegate.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 16/11/2022.
//

import UIKit
import SendbirdUIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //var userid: String?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        let APP_ID = "D05821D5-7D40-49E4-BC4C-B979DB317E94"    // Specify your Sendbird application ID.
            SendbirdUI.initialize(applicationId: APP_ID) { // This is the origin.
                // Initialization of SendbirdUIKit has started.
                // Show a loading indicator.
            } migrationHandler: {
                // DB migration has started.
            } completionHandler: { error in
                // If DB migration is successful, proceed to the next step.
                // If DB migration fails, an error exists.
                // Hide the loading indicator.
            }
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: 15)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font:UIFont(name: "HelveticaNeue", size: 15)!], for: .selected)
        
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

