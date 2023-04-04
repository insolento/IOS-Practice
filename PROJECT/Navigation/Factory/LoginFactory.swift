import Foundation
import UIKit

protocol LoginFactory {
    
    func makeLoginInspector() -> LoginInspector
    
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        let loginInspector = LoginInspector()
        return loginInspector
    }
    
    
}
