import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        
        
        let tabbarController = TabBarController()
        coordinator = AppCoordinator(tabBarController: tabbarController)
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

