import UIKit

protocol InitialScreenViewControllerOutput {
    func viewDidLoad()
}

protocol InitialScreenModelOutput {
}

class InitialScreenViewModel {
    
    var model: InitialScreenModelInput?
    weak var view: (InitialScreenViewControllerInput & AnyObject)?
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - InitialScreenViewControllerOutput
extension InitialScreenViewModel: InitialScreenViewControllerOutput {
    
    func viewDidLoad() {
        
        LocationService.shared.getLocation { [weak self] location in
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                  self != nil else {
                return
            }
            
            let viewController = MainScreenViewController.assemble(userLocation: location)
            let navigationController = UINavigationController(rootViewController: viewController)
            sceneDelegate.window?.rootViewController = navigationController
        }
    }
}

// MARK: - InitialScreenModelOutput
extension InitialScreenViewModel: InitialScreenModelOutput {
}
