import UIKit

protocol LoginViewControllerDelegate {
    func check(loginEntered: String, passwordEntered: String)
    func create(loginEntered: String, passwordEntered: String)
}
