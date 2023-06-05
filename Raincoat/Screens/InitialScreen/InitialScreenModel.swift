import Foundation

protocol InitialScreenModelInput {
}

class InitialScreenModel {
    
    private let viewModel: InitialScreenModelOutput
    
    init(viewModel: InitialScreenModelOutput) {
        self.viewModel = viewModel
    }
}

// MARK: - InitialScreenModelInput
extension InitialScreenModel: InitialScreenModelInput {
}
