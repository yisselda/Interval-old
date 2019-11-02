import UIKit

class RootCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  
  private let navigationController: UINavigationController
  private let spotifyClient: SpotifyClientType
  
  init(navigationController: UINavigationController,
       spotifyClient: SpotifyClientType = SpotifyClient.shared) {
    self.navigationController = navigationController
    self.spotifyClient = spotifyClient
  }
  
  func start() {
    
     if spotifyClient.isUserAuthenticated {
        // go to intervals
    } else {
        presentInitialViewController()
    }
  }
}

private extension RootCoordinator {
    func presentInitialViewController() {
        let viewController: ViewController = .instantiate()
        viewController.coordinator = self
        navigationController.present(viewController, animated: true)
    }
}
