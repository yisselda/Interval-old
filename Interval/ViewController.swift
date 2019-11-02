import UIKit

class ViewController: UIViewController {
  weak var coordinator: RootCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController : Storyboarded {}

