import UIKit

class Checker {
    
    private let password = "1234"
    private let login = "Hypster Cat"
    
    func check(loginEntered: String, passwordEntered: String) -> Bool {
        return loginEntered == login && passwordEntered == password
    }
}

protocol LoginViewControllerDelegate {
    func check(loginEntered: String, passwordEntered: String) -> Bool
    func dance()
}
