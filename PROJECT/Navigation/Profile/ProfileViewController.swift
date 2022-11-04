import UIKit

func emptyProfileController() -> UIViewController {
    let userService = emptyCurrentUser
    let profileVC = ProfileViewController(fullName: "", userService: userService)
    return profileVC
}

class ProfileViewController: UIViewController {
    
    var fullName: String

    var userService: UserService

    init(fullName: String, userService: UserService) {
        self.fullName = fullName
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let postInf: [(String, String, String, Int, Int)] = [
        ("holliwood_news", PostDescriptions.holliwoodNewsHamilton, "holliwoodNewsHamiltonPhoto", 2446,5400),
        ("ottofab", PostDescriptions.ottofabDog, "ottofabDogPhoto", 17428, 25345),
        ("sphynxcatlovers", PostDescriptions.sphynxcatloversCat, "sphynxcatloversCatPhoto", 3034, 12550),
        ("infocar.ua", PostDescriptions.infocarSilverado, "infocarSilveradoPhoto", 445, 1200),
        ("marvel", PostDescriptions.marvelEternals, "marvelEternalsPhoto", 1266291, 13544234),
    ]

    fileprivate enum CellReuseIdentifiers: String {
        case post = "PostCellReuse"
        case photos = "PhotosCellReuse"
    }

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.photos.rawValue)
        tableView.register(PostCellController.self, forCellReuseIdentifier: CellReuseIdentifiers.post.rawValue)
        return tableView
    }()
    
    var headerView: ProfileHeaderView = {
        var headerView = ProfileHeaderView()
        //headerView.layer.contents = userService.
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        headerViewSetup()
        addSubviews()
        autoresizingMask()
        layout()
        
        #if DEBUG
        view.backgroundColor = .systemBlue
        #else
        view.backgroundColor = .systemGray6
        #endif
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Profile"
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let indexPath = tableView.indexPathForSelectedRow else { return
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func headerViewSetup() {
        let currentUser: User = userService.findUser(userName: fullName)
        headerView.hipsterCat.text = currentUser.fullName
        headerView.catImageView.layer.contents = currentUser.profileImage.cgImage
        headerView.statusTextField.text = currentUser.status
    }
    
    func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
//        view.addSubview(profileTitle)
//        view.addSubview(profileTitleText)
    }
    
    func autoresizingMask() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
//        profileTitle.translatesAutoresizingMaskIntoConstraints = false
//        profileTitleText.translatesAutoresizingMaskIntoConstraints = false
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

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else { return postInf.count }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath[0] == 0 {
            guard let cell: PhotosTableViewCell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseIdentifiers.photos.rawValue,
                for: indexPath
            ) as? PhotosTableViewCell else {
                fatalError()
            }
            return cell
        } else {
            guard let cell: PostCellController = tableView.dequeueReusableCell(
                withIdentifier: CellReuseIdentifiers.post.rawValue,
                for: indexPath
            ) as? PostCellController else {
                fatalError()
            }
            
            // update data
            let data = postInf[indexPath.row]

            cell.update(author: data.0, description: data.1, image: data.2, likes: data.3, views: data.4)

            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let photosViewController = PhotosViewController()
//
//        if indexPath.row == 0 {
//            self.navigationController?.pushViewController(
//                photosViewController,
//                animated: true
//            )
//        }
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let uiView = UIView()
//        if section == 0 {
//            print(section)
//            tableView.addSubview(headerView)
//            headerView.heightAnchor.constraint(equalToConstant: 220).isActive = true
//            headerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
//            headerView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10).isActive = true
//            return headerView
//        } else { return uiView  }
//    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let coordinator = PhotosCoordinator()
            coordinator.getCoordinator(navigation: navigationController, coordinator: coordinator)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let uiView = UIView()
        if section == 0 {
            tableView.addSubview(headerView)
            headerView.heightAnchor.constraint(equalToConstant: 220).isActive = true
            headerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
            headerView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10).isActive = true
            return headerView
        } else { return uiView  }
    }
}
