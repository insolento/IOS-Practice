import UIKit

class Checker {
    
    private let password = "1234"
    private let login = "Hypster Cat"
    
    func check(loginEntered: String, passwordEntered: String) -> Bool {
        if loginEntered == login && passwordEntered == password {
            return true
        } else {
            return false
        }
    }
}

protocol LoginViewControllerDelegate {
    func check(loginEntered: String, passwordEntered: String) -> Bool
    func dance()
}
