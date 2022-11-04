import UIKit

class Checker {
    
    private let password = "1"
    private let login = "H"
    
    func check(loginEntered: String, passwordEntered: String) -> Bool {
        return loginEntered == login && passwordEntered == password
    }
}

protocol LoginViewControllerDelegate {
    func check(loginEntered: String, passwordEntered: String) -> Bool
    func dance()
}
