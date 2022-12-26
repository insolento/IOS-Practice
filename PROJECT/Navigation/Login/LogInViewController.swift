import UIKit

enum LoginMessage {
    case newUser
    case wrongInfo
    case rightUser
}

class LogInViewController: UIViewController {
    
    var loginDelegate: LoginViewControllerDelegate?
    
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    lazy var alertController: UIAlertController = {
        let alert = UIAlertController(title: "",
                                      message: "Вы можете попробовать ввести его снова",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: { _ in }))
        return alert
    }()
    
    lazy var wrongAlertController: UIAlertController = {
        let alert = UIAlertController(title: "",
                                      message: "Вы можете попробовать ввести его снова",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: { _ in }))
        return alert
    }()
    
    lazy var wrongInputAlertController: UIAlertController = {
        let alert = UIAlertController(title: "",
                                      message: "Вы можете попробовать ввести его снова",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: { _ in }))
        return alert
    }()
    
    lazy var passwordAlertController: UIAlertController = {
        let alert = UIAlertController(title: "",
                                      message: "Вы можете попробовать ввести его снова",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: { _ in }))
        return alert
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //let profile: UIViewController = ProfileViewController(fullName: "Hipster Cat", userService: hipsterCat)
    
    let logoView: UIView = {
        let logoView = UIView()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.layer.contents = Constants.logoImage
        return logoView
    }()
    
    let logInButton: CustomButton = {
        let button = CustomButton(title: "Log In", titleColor: .white, radius: 10, backgroundColor: .clear)
        button.layer.masksToBounds = true
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    let login: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Email or phone"
        field.backgroundColor = .systemGray6
        field.textColor = .black
        field.font = UIFont.systemFont(ofSize: 16)
        field.tintColor = UIColor(named: "VKColor")
        field.autocapitalizationType = .none
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        field.text = ""
        return field
    }()
    
    let password: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Password"
        field.backgroundColor = .systemGray6
        field.textColor = .black
        field.font = UIFont.systemFont(ofSize: 16)
        field.tintColor = UIColor(named: "VKColor")
        field.autocapitalizationType = .none
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.isSecureTextEntry = true
        field.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        field.text = ""
        return field
    }()
    
    let loginView: UIView = {
        let loginView = UIView()
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.layer.cornerRadius = 10
        loginView.layer.masksToBounds = true
        loginView.layer.borderWidth = 0.5
        loginView.layer.borderColor = UIColor.lightGray.cgColor
        return loginView
    }()
    
    let bruteButton: CustomButton = {
        let button = CustomButton(title: "Подобрать пароль", titleColor: .blue, radius: 10, backgroundColor: .clear)
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.backgroundColor = .systemBackground
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        addSubviews()
        view.addGestureRecognizer(tap)
        layout()
        setupButton()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupButton() {
        logInButton.function = { [weak self] in
            self?.logIn()
        }
        bruteButton.function = { [weak self] in
            self?.bruteAdding()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    @objc func logIn() {
//        if login.text!.count  > 0 {
//            if password.text!.count > 0 {
//                self.navigationController?.pushViewController(profile, animated: true)
//            } else { print("Enter password!") }
//        } else { print("Enter email or phone number!") }
//    }
// Вариант с проверкой на ввод, оставлю закоменченным
    
    func logIn() {
        loginDelegate?.check(loginEntered: login.text!, passwordEntered: password.text!)
//        if checkResults ?? false {
//            let coordinator = ProfileCoordinator()
//            #if DEBUG
//            coordinator.getCoordinator(navigation: navigationController, coordinator: coordinator, fullName: CurrentHipsterCat.user.fullName, userSrvice: CurrentHipsterCat)
//            #else
//            coordinator.getCoordinator(navigation: navigationController, coordinator: coordinator, fullName: TestUserService.user.fullName, userSrvice: TestUserService)
//            #endif
//        } else {
//            self.present(alertController, animated: true)
//        }
        NotificationCenter.default.addObserver(self, selector: #selector(rightPassword), name: .rightPasswordEvent, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(wrongPassword), name: .wrongPasswordEvent, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(newUser), name: .newUserEvent, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(wrongInput), name: .wrongInputEvent, object: nil)
        if (login.text=="") || (password.text=="") {
            alertController.title = "Вы не ввели логин или пароль"
            //self.present(alertController, animated: true)
        }
        
        
    }
    
    @objc func rightPassword() {
        let coordinator = ProfileCoordinator()
        coordinator.getCoordinator(navigation: navigationController, coordinator: coordinator, fullName: CurrentHipsterCat.user.fullName, userSrvice: CurrentHipsterCat)
    }
    
    @objc func wrongPassword() {
        wrongAlertController.title = "Вы ввели неправильный пароль"
        self.present(wrongAlertController, animated: true)
    }
    
    @objc func wrongInput() {
        wrongInputAlertController.title = "Почта некорректна"
        wrongInputAlertController.message = "Попробуйте ввести правильный email адрес, если это не помогло, обратитесь в службу поддержки"
        self.present(wrongInputAlertController, animated: true)
    }
    
    @objc func newUser() {
        let newUserAllert: UIAlertController = {
            let alert = UIAlertController(title: "Пользователь не найдет",
                                          message: "Хотите создать нового пользователя с этими данными?",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Нет", style: .destructive))
            alert.addAction(UIAlertAction(title: "Да", style: .cancel, handler: {_ in self.createNewUser()}))
            return alert
        }()
        self.present(newUserAllert, animated: true)
        if password.text!.count < 6 {
            passwordAlertController.title = "Пароль должен быть 6 символов и больше"
            self.present(passwordAlertController, animated: true)
            passwordAlertController.dismiss(animated: true)
        }
    }
    
    func createNewUser() {
        loginDelegate?.create(loginEntered: login.text!, passwordEntered: password.text!)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func bruteAdding() {
        activityIndicatorView.startAnimating()
        var brutePassword = ""
        let bruteItem = DispatchWorkItem {
            let bruteForce = BruteForce()
            brutePassword = bruteForce.bruteForce(passwordToUnlock: "123q")
        }
        let endAnmationItem = {
            self.activityIndicatorView.stopAnimating()
            self.password.text = brutePassword
            self.password.isSecureTextEntry = false
        }
        bruteItem.notify(queue: .main, execute: endAnmationItem)
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 1, execute: bruteItem)
        //Добавил секунду ожидания, что б даже с самым простым паролем успела сыграть анимация
    }
    
    func addSubviews() {
        view.addSubview(logInButton)
        view.addSubview(logoView)
        view.addSubview(loginView)
        view.addSubview(scrollView)
        view.addSubview(bruteButton)
        view.addSubview(activityIndicatorView)
        loginView.addSubview(login)
        loginView.addSubview(password)
        scrollView.addSubview(logInButton)
        scrollView.addSubview(logoView)
        scrollView.addSubview(loginView)
        scrollView.addSubview(bruteButton)
        scrollView.addSubview(activityIndicatorView)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 2000),
            logInButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logInButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 456),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 100.0),
            logoView.widthAnchor.constraint(equalToConstant: 100.0),
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 340),
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginView.heightAnchor.constraint(equalToConstant: 100),
            password.bottomAnchor.constraint(equalTo: loginView.bottomAnchor),
            password.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            password.heightAnchor.constraint(equalToConstant: 50),
            login.topAnchor.constraint(equalTo: loginView.topAnchor),
            login.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            login.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            login.heightAnchor.constraint(equalToConstant: 50),
            bruteButton.leadingAnchor.constraint(equalTo: logInButton.leadingAnchor, constant: 40),
            bruteButton.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor, constant: -40),
            bruteButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            activityIndicatorView.leadingAnchor.constraint(equalTo: bruteButton.trailingAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: bruteButton.topAnchor, constant: 8),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 16),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
}


extension NSNotification.Name {
    static let wrongPasswordEvent = NSNotification.Name("wrongPassword")
    static let rightPasswordEvent = NSNotification.Name("rightPassword")
    static let newUserEvent = NSNotification.Name("newUserEvent")
    static let wrongInputEvent = NSNotification.Name("wrongInput")
}
