//
//  TabBarController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 4/12/2022.
//

import UIKit

class TabBarController: UITabBarController{
    override func viewDidLoad() {
      super.viewDidLoad()
      delegate = self

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
