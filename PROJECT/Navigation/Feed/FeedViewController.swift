import UIKit

class FeedViewController: UIViewController {
    let postController = PostViewController()
    
    let feedModel = FeedModel()
    
    let passwordTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.heightAnchor.constraint(equalToConstant: 50).isActive = true
        field.widthAnchor.constraint(equalToConstant: 230).isActive = true
        field.placeholder = "Password word"
        field.backgroundColor = .systemGray6
        field.textColor = .black
        field.font = UIFont.systemFont(ofSize: 16)
        field.autocapitalizationType = .none
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.cornerRadius = 10
        field.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        field.text = ""
        return field
    }()
    
    
    let checkButton: CustomButton = {
        let button = CustomButton(title: "Check", titleColor: .blue, radius: 10, backgroundColor: .clear)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 230).isActive = true
        return button
    }()
    
    
    let buttonToPost: CustomButton = {
        let buttonToPost = CustomButton(title: "Open Post", titleColor: .blue, radius: 0, backgroundColor: .clear)
        //let buttonToPost = CustomButton(title: "Open Post", titleColor: .blue, completition: #selector(openPost))
        buttonToPost.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        return buttonToPost
    }()
    
    let secondButton: CustomButton = {
        let buttonToPost = CustomButton(title: "Open Post", titleColor: .blue, radius: 0, backgroundColor: .clear)
        //let buttonToPost = CustomButton(title: "Open Post", titleColor: .blue, completition: #selector(openPost))
        buttonToPost.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        return buttonToPost
    }()
    
    let thirdButton: CustomButton = {
        let buttonToPost = CustomButton(title: "Open Post", titleColor: .blue, radius: 0, backgroundColor: .clear)
        //let buttonToPost = CustomButton(title: "Open Post", titleColor: .blue, completition: #selector(openPost))
        buttonToPost.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        return buttonToPost
    }()
    
    let buttonStackView: UIStackView = {
        let buttonStackView = UIStackView()
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .equalSpacing
        buttonStackView.alignment = .center
        buttonStackView.spacing = 10.0
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonStackView
    }()
    
    let coreectnessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        stackAddSubviews()
        view.addSubview(buttonStackView)
        view.addSubview(passwordTextField)
        view.addSubview(checkButton)
        view.addSubview(coreectnessLabel)
        layout()
        buttonsFunctions()
        NotificationCenter.default.addObserver(self, selector: #selector(wrongWord), name: .wrongWordEvent, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rightWord), name: .rightWordEvent, object: nil)
    }
    
    func buttonsFunctions() {
        checkButton.function = { [weak self] in
            self?.feedModel.check(self?.passwordTextField.text ?? "")
        }
        buttonToPost.function = { [weak self] in
            self?.openPost()
        }
        secondButton.function = { [weak self] in
            self?.openPost()
        }
        
        thirdButton.function = { [weak self] in
            self?.openPost()
        }
    }
    
    @objc func openPost() {
        self.navigationController?.pushViewController(postController, animated: true)
    }
    
    @objc func wrongWord() {
        coreectnessLabel.text = "Слово неверное"
        coreectnessLabel.textColor = .red
    }
    
    @objc func rightWord() {
        coreectnessLabel.text = "Слово верное"
        coreectnessLabel.textColor = .green
    }

    func stackAddSubviews() {
        buttonStackView.addArrangedSubview(buttonToPost)
        buttonStackView.addArrangedSubview(secondButton)
        buttonStackView.addArrangedSubview(thirdButton)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -16.0),
            buttonStackView.heightAnchor.constraint(equalToConstant: 200.0),
            passwordTextField.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coreectnessLabel.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 16),
            coreectnessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

extension NSNotification.Name {
    static let wrongWordEvent = NSNotification.Name("wrongWord")
    static let rightWordEvent = NSNotification.Name("rightWord")
}

