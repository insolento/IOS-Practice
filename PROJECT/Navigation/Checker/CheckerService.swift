import Foundation
import FirebaseAuth
import RealmSwift
import KeychainAccess

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String)
    func singUp(email: String, password: String)
}

class CheckerService: CheckerServiceProtocol {
    let realm = try! Realm()
    let keychain = Keychain(service: "keepLogedIn")
    
    func checkCredentials(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authresult, error in
            if authresult == nil {
                if let errorMessage = error?.localizedDescription {
                    if errorMessage == "There is no user record corresponding to this identifier. The user may have been deleted." {
                        NotificationCenter.default.post(name: .newUserEvent, object: nil)
                    } else if errorMessage == "The password is invalid or the user does not have a password." {
                        NotificationCenter.default.post(name: .wrongPasswordEvent, object: nil)
                    } else {
                        NotificationCenter.default.post(name: .wrongInputEvent, object: nil)
                    }
                }
            } else {
                NotificationCenter.default.post(name: .rightPasswordEvent, object: nil)
                self.keychain["username"] = email
                self.keychain["password"] = password
            }
            
        }
    }
    
    func singUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {responce,error in
            print("Error = \(error)")
            print("Responce = \(responce)")
        }
        var login = LoginModel()
        login.login = email
        login.password = password
        try! realm.write {
            realm.add(login)
        }
    }
    
    
}
