import Foundation
import UIKit

//protocol childCoordinator {
//    func getCoordinator(coordinator: Coordinator) -> UIViewController
//}

final class FeedCoordinator {
    func getCoordinator(coordinator: FeedCoordinator) -> UIViewController {
        let viewModel = FeedViewModel(model: FeedModel())
        let viewController = FeedViewController(viewModel: viewModel, coordinator: coordinator)
        return viewController
    }
}

final class PostCoordinator {
    func getCoordinator(navigation: UINavigationController,coordinator: PostCoordinator)  {
        let viewController = PostViewController()
        navigation.pushViewController(viewController, animated: true)
    }
}

final class InfoCoordinator {
    func getCoordinator(navigation: UINavigationController?,coordinator: InfoCoordinator)  {
        let viewController = InfoViewController()
        navigation?.present(viewController, animated: true)
    }
}
