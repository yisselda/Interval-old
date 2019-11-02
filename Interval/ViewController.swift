import UIKit

class ViewController: UIViewController, Storyboarded {
    weak var coordinator: RootCoordinator?
    
    var viewModel: SpotifyAuthViewModelType!
    
    @IBAction func spotifyConnect(_ sender: Any) {
        viewModel.connect()
        
//      ? coordinator?.showIntervals() : coordinator?.showConnectionError()
    }
    
    func setup(with viewModel: SpotifyAuthViewModelType) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

