//
//  TabBarController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 4/12/2022.
//

//
//  TabBarController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 4/12/2022.
//

import UIKit
import SendbirdUIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        // Get references to your existing view controllers from the storyboard
        guard let profile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileItem") as? ProfilePostsViewController,
              let feed = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "feedItem") as? FeedViewController else {
            fatalError("Unable to instantiate view controllers from storyboard")
        }
        
        // Create an instance of SBUGroupChannelListViewController
        let channelListVC = SBUGroupChannelListViewController()
        channelListVC.navigationItem.hidesBackButton = true
        channelListVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "text.bubble"), tag: 0)
        channelListVC.navigationItem.hidesBackButton = true
        
        // Embed each of your existing view controllers in a navigation controller
        let profileController = UINavigationController(rootViewController: profile)
        let feedController = UINavigationController(rootViewController: feed)
        let navigationController = UINavigationController(rootViewController: channelListVC)

        
        
        // Set the view controllers for the tab bar controller
        viewControllers = [feedController,navigationController, profileController ]
    }
    
}


extension TabBarController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
          return false // Make sure you want this as false
        }

        if fromView != toView {
          
            
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }

        return true
    }
}
