import Foundation
import UIKit


class CustomButton: UIButton {
    
    var title: String = ""
    var color: UIColor = UIColor()
    var function: (()->Void)?
    
    required init(title: String, titleColor: UIColor, radius: Int, backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 10
        self.backgroundColor = backgroundColor
        self.title = title
        self.color = titleColor
        self.translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.setTitle("\(title)", for: .normal)
        self.setTitleColor(color, for: .normal)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)    }
    
    @objc func buttonTapped() {
        function?()
    }
}
