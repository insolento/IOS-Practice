import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = .systemGray6
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor.systemGray.cgColor
        
        
        let factory = MyLoginFactory()
        
        let loginInspector = factory.makeLoginInspector()
        
        let logIn = LogInViewController()
        let logInNavigationController = UINavigationController(rootViewController: logIn)
        logInNavigationController.navigationBar.topItem?.title = "Log In"
        let logInTabBar = UITabBarItem()
        logInTabBar.image = UIImage(systemName: "person.crop.circle")
        logInTabBar.badgeColor = UIColor(named: "VKColor")
        logInTabBar.title = "Log In"
        logInNavigationController.tabBarItem = logInTabBar
        logIn.loginDelegate = loginInspector
        let feedAssembly = FeedAssembly()
        let feed = feedAssembly.make()
        let feedNavigationController = UINavigationController(rootViewController: feed)
        let feedName = UITabBarItem()
        feedName.title = "Feed"
        feedName.image = UIImage(systemName: "house")
    
        feedNavigationController.tabBarItem = feedName
        self.viewControllers = [logInNavigationController, feedNavigationController]
        
    }
    
    
    
}
