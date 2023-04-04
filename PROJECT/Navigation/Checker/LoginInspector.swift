import Foundation
import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    func check(loginEntered: String, passwordEntered: String) {
        let check = CheckerService()
        return check.checkCredentials(email: loginEntered, password: passwordEntered)
    }
    func create(loginEntered: String, passwordEntered: String)  {
        let check = CheckerService()
        check.singUp(email: loginEntered, password: passwordEntered)
    }
}
