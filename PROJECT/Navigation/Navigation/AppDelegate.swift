import UIKit
import Firebase
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        FirebaseApp.configure()
        let mainCoordinator = AppCoordinator(navigationController: UINavigationController())
        window?.rootViewController = mainCoordinator.start()
        window?.makeKeyAndVisible()
        
        return true
    }
}

