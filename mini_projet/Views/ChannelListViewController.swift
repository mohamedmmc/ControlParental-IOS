import UIKit
import SendbirdUIKit

class ChannelListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create an instance of SBUGroupChannelListViewController
        let channelListVC = SBUGroupChannelListViewController()

        // Set the title for the view controller
        channelListVC.title = "Channels"

        // Create a tab bar item for the view controller
        let tabBarItem = UITabBarItem(title: "Channels", image: UIImage(named: "channel-icon"), tag: 0)

        // Set the tab bar item for the view controller
        channelListVC.tabBarItem = tabBarItem

        // Add the new view controller to the existing tab bar controller
        if var tabBarControllers = tabBarController?.viewControllers {
            // If you have more than one tab, you can add the new tab at a specific index
            let index = 2

            // Embed the SBUGroupChannelListViewController in a UINavigationController
            let navigationController = UINavigationController(rootViewController: channelListVC)

            // Set the navigation bar style as desired
            navigationController.navigationBar.barTintColor = .white
            navigationController.navigationBar.tintColor = .black
            navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

            // Replace the existing tab view controller at the specified index with the new navigation controller
            tabBarControllers[index] = navigationController

            // Set the updated view controllers for the tab bar controller
            tabBarController?.viewControllers = tabBarControllers
        }
    }
}
