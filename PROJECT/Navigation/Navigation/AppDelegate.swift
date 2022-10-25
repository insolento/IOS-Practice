import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let factory = MyLoginFactory()
        
        let tabbarController = UITabBarController()
        tabbarController.tabBar.backgroundColor = .systemGray6
        tabbarController.tabBar.layer.borderWidth = 0.5
        tabbarController.tabBar.layer.borderColor = UIColor.systemGray.cgColor

        
//        let profile = ProfileViewController(fullName: "Hipster Cat", userService: hipsterCat)
//        let profileNavigationController = UINavigationController(rootViewController: profile)
//        let profileName = UITabBarItem()
//        profileName.image = UIImage(systemName: "person.crop.circle")
//        profileName.title = "Profile"
//        profileNavigationController.tabBarItem = profileName
        
        let logIn = LogInViewController()
        let logInNavigationController = UINavigationController(rootViewController: logIn)
        logInNavigationController.navigationBar.topItem?.title = "Log In"
        let logInTabBar = UITabBarItem()
        logInTabBar.image = UIImage(systemName: "person.crop.circle")
        logInTabBar.badgeColor = UIColor(named: "VKColor")
        logInTabBar.title = "Log In"
        logInNavigationController.tabBarItem = logInTabBar
        let loginInspector = factory.makeLoginInspector()
        logIn.loginDelegate = loginInspector
        
        
        let feed = FeedViewController()
        let feedNavigationController = UINavigationController(rootViewController: feed)
        let feedName = UITabBarItem()
        feedName.title = "Feed"
        feedName.image = UIImage(systemName: "house")
        
        feedNavigationController.tabBarItem = feedName
        
        tabbarController.viewControllers = [logInNavigationController, feedNavigationController]
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        return true
    }
}

