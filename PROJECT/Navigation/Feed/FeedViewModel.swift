import Foundation

protocol FeedViewModelProtocol: AnyObject {
    func openPost()
    func checkWord(word: String)
}

class FeedViewModel: FeedViewModelProtocol {
    // не уверен стоило ли как то еще перенести ф ционал, так же может стоило сделать как то "бинды"? не до конца понял их ф ционал
    func openPost() {
        // можно какие то проверки, так же наверное тут могу передавать разные контроллеры для открытия и передавать какие то данные, то есть тут
        // ViewModel как будто контролирует все и это действие View
        NotificationCenter.default.post(name: .openPost, object: nil)
    }
    
    func checkWord(word: String) {
        // связь с данными и ф циями Model
        self.model.check(word)
    }
    
    let postController = PostViewController()
    
    let model: FeedModel
    
    init(model: FeedModel) {
        self.model = model
    }
}

extension NSNotification.Name {
    static let wrongWordEvent = NSNotification.Name("wrongWord")
    static let rightWordEvent = NSNotification.Name("rightWord")
    static let openPost = NSNotification.Name("openPost")
}

