import UIKit

class RootCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  
  private let navigationController: UINavigationController
  private let spotifyClient: SpotifyClient
  
  init(navigationController: UINavigationController,
       spotifyClient: SpotifyClient = .shared) {
    self.navigationController = navigationController
    self.spotifyClient = spotifyClient
  }
  
  func start() {
    // if is authed
    let viewController: ViewController = .instantiate()
    viewController.coordinator = self
    navigationController.present(viewController, animated: true)
    //else present list of combos
  }
}
