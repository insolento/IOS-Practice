import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    var logInNavigationController = UINavigationController()
    var feedNavigationController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        setupLogin()
        setupProfile()
        self.viewControllers = [logInNavigationController, feedNavigationController]
        networkTest()
    }
    
    func networkTest() {
        let networkService = NetworkService()
        networkService.request(configuraion: .starships)
    }
    
    
    
    func setupTabbar() {
        self.tabBar.backgroundColor = .systemGray6
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor.systemGray.cgColor
        
    }
    
    func setupLogin() {
        let coordinator = LoginCoordinator()
        let logIn = coordinator.getCoordinator(coordinator: coordinator)
        logInNavigationController = UINavigationController(rootViewController: logIn)
        logInNavigationController.navigationBar.topItem?.title = "Log In"
        let logInTabBar = UITabBarItem()
        logInNavigationController.tabBarItem = logInTabBar
        logInTabBar.image = UIImage(systemName: "person.crop.circle")
        logInTabBar.badgeColor = UIColor(named: "VKColor")
        logInTabBar.title = "Log In"
    }
    
    func setupProfile() {
        //let feedAssembly = FeedAssembly()
        //let feed = feedAssembly.make()
        let coordinator = FeedCoordinator()
        let feed = coordinator.getCoordinator(coordinator: coordinator)
        feedNavigationController = UINavigationController(rootViewController: feed)
        let feedName = UITabBarItem()
        feedName.title = "Feed"
        feedName.image = UIImage(systemName: "house")
    feedNavigationController.tabBarItem = feedName
    }

    
}
