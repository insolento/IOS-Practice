import Foundation

class FeedAssembly {
    func make() -> FeedViewController {
        let model = FeedModel()
        let viewModel = FeedViewModel(model: model)
        let view = FeedViewController()
        
        view.viewModel = viewModel
        
        return view
    }
}
