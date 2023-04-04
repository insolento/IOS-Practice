import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let imageList = (1...20).compactMap {UIImage(named: "photo\($0)")}
    
    var statusLabel: String = "Waiting for something..."
    
    let showStatusButton: CustomButton = {
        let statusButton = CustomButton(title: "Show status", titleColor: .white, radius: 4, backgroundColor: .blue)
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        return statusButton
    }()
    
    let catImageView: UIView = {
        let catImage = UIView()
        catImage.layer.contents = Constants.avatarImageView
        catImage.layer.borderWidth = 3
        catImage.layer.masksToBounds = false
        catImage.layer.borderColor = UIColor.white.cgColor
        catImage.layer.cornerRadius = 50
        catImage.clipsToBounds = true
        return catImage
    }()
    
    let statusTextField: UILabel = {
        let textField = UILabel()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    
    let hipsterCat: UILabel = {
        let cat = UILabel()
        cat.text = "Hipster Cat"
        cat.font = UIFont.systemFont(ofSize: 18)
        cat.textColor = .black
        cat.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return cat
    }()

    private func setUpView() {
        autoresizingMaks()
        addSubviews()
        layout()
        backgroundColor = .systemGray6
        statusTextField.text = statusLabel
        buttonSetup()
        photoTimer()
    }
    
    func photoTimer() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(changePhoto), userInfo: nil, repeats: true)
    }
    
    @objc func changePhoto() {
        catImageView.layer.contents = imageList.randomElement()?.cgImage
    }
    //Смена котов на аватарке каждые 5 секунд, вродь прикольно
    
     func buttonSetup() {
         showStatusButton.function = {
            print(self.statusLabel)
        }
    }
    
    func autoresizingMaks() {
        catImageView.translatesAutoresizingMaskIntoConstraints = false
        showStatusButton.translatesAutoresizingMaskIntoConstraints = false
        hipsterCat.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews() {
        self.addSubview(catImageView)
        self.addSubview(showStatusButton)
        self.addSubview(hipsterCat)
        self.addSubview(statusTextField)
    }
    
    func layout() {
        
        //Здравствуйте, сделал как нашёл, подскажите, был ли способ упростить? Спасибо!
        
        catImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.leading.equalTo(self).offset(16)
            make.top.equalTo(self.snp.bottom).offset(16)
        }
        
        hipsterCat.snp.makeConstraints { (make) in
            make.leading.equalTo(catImageView.snp.trailing).offset(20)
            make.trailing.equalTo(self)
            make.top.equalTo(self.snp.bottom).offset(27)
        }
        
        showStatusButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.leading.equalTo(self).offset(16)
            make.top.equalTo(catImageView.snp.bottom).offset(16)
            make.trailing.equalTo(self).offset(-16)
        }
        //Выше хотел сделать что то по типу make.edges.equalTo(self).inset(UIEdgeInsetsMake(16, 16, -16, -)), но не уловил как реализовать указав только три стороны максимально коротко
        
        statusTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(showStatusButton.snp.top).offset(-34)
            make.leading.equalTo(catImageView.snp.trailing).offset(20)
            make.trailing.equalTo(self)
        }
//        NSLayoutConstraint.activate([
//            catImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            catImageView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 16.0),
//            catImageView.heightAnchor.constraint(equalToConstant: 100.0),
//            catImageView.widthAnchor.constraint(equalToConstant: 100.0),
//            hipsterCat.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 20),
//            hipsterCat.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            hipsterCat.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 27),
//            showStatusButton.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 16),
//            showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            showStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
//            statusTextField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -34),
//            statusTextField.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 20),
//            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//        ])
    }

}
