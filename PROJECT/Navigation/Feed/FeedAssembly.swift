import Foundation

class FeedAssembly {
    //НЕ НУЖЕН в случае с Контроллером, это чисто для примера с MVVM, не уверен что нужен ассемблер, когда я init'ом всё принимаю
    func make() -> FeedViewController {
        let model = FeedModel()
        let viewModel = FeedViewModel(model: model)
        let view = FeedViewController(viewModel: viewModel, coordinator: FeedCoordinator())
        view.viewModel = viewModel
        
        return view
    }
}
