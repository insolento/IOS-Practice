import Foundation
import UIKit

final class LoginCoordinator {
    func getCoordinator(coordinator: LoginCoordinator) -> UIViewController {
        let factory = MyLoginFactory()
        let logIn = LogInViewController()
        let loginInspector = factory.makeLoginInspector()
        logIn.loginDelegate = loginInspector
        return logIn
    }
}


final class ProfileCoordinator {
    func getCoordinator(navigation: UINavigationController?,coordinator: ProfileCoordinator, fullName: String, userSrvice: UserService) {
        let viewController = ProfileViewController(fullName: fullName, userService: userSrvice)
        navigation?.pushViewController(viewController, animated: true)
    }
}

final class PhotosCoordinator {
    func getCoordinator(navigation: UINavigationController?, coordinator: PhotosCoordinator) {
        let viewController = PhotosViewController()
        navigation?.pushViewController(viewController, animated: true)
    }
    
}

final class PhotoCoordinator {
    func getCoordinator(navigation: UINavigationController?, coordinator: PhotoCoordinator, photoName: String) {
        let viewController = PhotosOpenViewController()
        viewController.setup(photoName)
        navigation?.pushViewController(viewController, animated: true)
    }
}
