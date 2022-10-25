import Foundation
import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    func check(loginEntered: String, passwordEntered: String) -> Bool {
        let check = Checker()
        return check.check(loginEntered: loginEntered, passwordEntered: passwordEntered)
    }
    func dance() {
        print("We are dancing!!!")
    }
}
