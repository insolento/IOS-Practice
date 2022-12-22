
import UIKit

class PostViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Информация", style: .plain, target: self, action: #selector(openInfo))
        let screenSize = UIScreen.main.bounds
        let title = UILabel(frame: CGRect(x: screenSize.width*0.5 - 25, y: 100, width: 100, height: 150))
        title.text = "Пост"
        navigationItem.title = "Пост"
        
        view.addSubview(title)
    }
    @objc func openInfo() {
        let infoCoordinator = InfoCoordinator()
        infoCoordinator.getCoordinator(navigation: navigationController, coordinator: infoCoordinator)
    }

}
