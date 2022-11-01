import UIKit

protocol Storyboardable {
    static func createObject() -> Self
}


//extension Storyboardable where Self: UIViewController {
//    static func createObject() -> {
//        let id = String(describing: self)
//        
//    }
//}
