import Foundation

class FeedModel {
    
    private let secretWord = "Hypster"
    
    func check(_ word: String) {
        if word == secretWord {
            NotificationCenter.default.post(name: .rightWordEvent, object: nil)
        } else {
            NotificationCenter.default.post(name: .wrongWordEvent, object: nil)
        }
    }
    
}
