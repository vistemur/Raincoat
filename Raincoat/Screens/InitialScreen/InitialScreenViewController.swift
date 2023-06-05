import UIKit

protocol InitialScreenViewControllerInput {
}

class InitialScreenViewController: UIViewController {
    
    // MARK: - UI properties

    var viewModel: InitialScreenViewControllerOutput?
    
    // MARK: - life cycle
    override func viewDidLoad() {
        setup()
        viewModel?.viewDidLoad()
        super.viewDidLoad()
    }
    
    // MARK: - setup
    private func setup() {
    }
}

// MARK: - InitialScreenViewControllerInput
extension InitialScreenViewController: InitialScreenViewControllerInput {
}

// MARK: - Assemble
extension InitialScreenViewController {
    
    static func assemble(window: UIWindow) -> UIViewController {
        let view = InitialScreenViewController()
        let viewModel = InitialScreenViewModel(window: window)
        let model = InitialScreenModel(viewModel: viewModel)
        
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.model = model
        return view
    }
}
