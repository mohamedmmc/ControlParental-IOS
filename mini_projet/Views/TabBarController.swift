//
//  TabBarController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 4/12/2022.
//

import UIKit
import SendbirdUIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    

    
    @IBOutlet weak var tabbar: UITabBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let indexOfTab = tabBar.items?.firstIndex(of: item)
        print("pressed tabBar: \(String(describing: indexOfTab))")
        if (indexOfTab == 1) {
            
            let groupChannelListVC = SBUGroupChannelListViewController()
            let naviVC = UINavigationController(rootViewController: groupChannelListVC)
            naviVC.modalPresentationStyle = .fullScreen

            self.present(naviVC, animated: true)
        }
    }
    
    

 
}
