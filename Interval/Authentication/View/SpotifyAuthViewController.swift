import UIKit

class SpotifyAuthViewController: UIViewController, Storyboarded {
    
    weak var coordinator: RootCoordinator?
    
    var viewModel: SpotifyAuthViewModelType! {
        didSet {
            self.setup(with: viewModel)
        }
    }
    
    @IBAction func spotifyConnect(_ sender: Any) {
        viewModel.connect()
    }
}

private extension SpotifyAuthViewController {
    func setup(with viewModel: SpotifyAuthViewModelType) {
        viewModel.delegate = self
    }
}

extension SpotifyAuthViewController: SpotifyAuthViewModelDelegate {
    func didConnect() {
        coordinator?.showIntervals()
    }
}
