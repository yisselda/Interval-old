import UIKit

class RootCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var topViewController: UIViewController? {
        return navigationController.topViewController
    }

    private let navigationController: UINavigationController
    private let spotifyClient: SpotifyClientType
    
    init(navigationController: UINavigationController,
         spotifyClient: SpotifyClientType = SpotifyClient.shared) {
        self.navigationController = navigationController
        self.spotifyClient = spotifyClient
    }
    
    func start() {
        
//        if spotifyClient.isUserAuthenticated {
            showIntervals()
//        } else {
//            presentInitialViewController()
//        }
    }
    
    func showIntervals() {
        debugPrint("showIntervals \(#function)")
        let viewController: ComboDetailViewController = .instantiate()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showConnectionError() {
        debugPrint("Connection error \(#function)")
    }
}

private extension RootCoordinator {
    func presentInitialViewController() {
        let spotifyAuthViewModel = SpotifyAuthViewModel(spotifyClient: spotifyClient)
        let viewController: SpotifyAuthViewController = .instantiate()
        viewController.viewModel = spotifyAuthViewModel
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
