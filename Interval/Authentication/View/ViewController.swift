import UIKit

class ViewController: UIViewController, Storyboarded {
    
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

private extension ViewController {
    func setup(with viewModel: SpotifyAuthViewModelType) {
        // placeholder
    }
}

