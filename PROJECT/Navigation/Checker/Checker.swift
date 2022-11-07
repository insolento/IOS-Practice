import UIKit

class Checker {
    
    private let password = "123q"
    private let login = "Hypster"
    
    func check(loginEntered: String, passwordEntered: String) -> Bool {
        return loginEntered == login && passwordEntered == password
    }
}

protocol LoginViewControllerDelegate {
    func check(loginEntered: String, passwordEntered: String) -> Bool
    func dance()
}
