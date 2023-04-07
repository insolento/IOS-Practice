import UIKit

class FavouritesViewController: UIViewController {
    
    fileprivate let postInf: [(String, String, String, Int, Int)] = [
        ("holliwood_news", PostDescriptions.holliwoodNewsHamilton, "holliwoodNewsHamiltonPhoto", 2446,5400),
        ("ottofab", PostDescriptions.ottofabDog, "ottofabDogPhoto", 17428, 25345),
        ("sphynxcatlovers", PostDescriptions.sphynxcatloversCat, "sphynxcatloversCatPhoto", 3034, 12550),
        ("infocar.ua", PostDescriptions.infocarSilverado, "infocarSilveradoPhoto", 445, 1200),
        ("marvel", PostDescriptions.marvelEternals, "marvelEternalsPhoto", 1266291, 13544234),
    ]
    let posts = Posts()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostCellController.self, forCellReuseIdentifier: "PostCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        layout()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
extension FavouritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBaseModel.shared.getFavoritePosts().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PostCellController = tableView.dequeueReusableCell(
            withIdentifier: "PostCell",
            for: indexPath
        ) as? PostCellController else {
            fatalError()
        }
            
        // update data
        let data = DataBaseModel.shared.getFavoritePosts()[indexPath.row]

        cell.update(post: data)

        return cell
    }
}

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinator = PhotosCoordinator()
        coordinator.getCoordinator(navigation: navigationController, coordinator: coordinator)
    }
}
