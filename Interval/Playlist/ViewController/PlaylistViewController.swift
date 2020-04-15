// TODO Prefetch Data
// https://developer.apple.com/documentation/uikit/uiimage/asynchronously_loading_images_into_table_and_collection_views


import UIKit

class PlaylistViewController: UIViewController, Storyboarded {
    
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var combos: [Combo] = [
        Combo(title: "Sass At Home: I'll Kill You - Summer Walker"),
        Combo(title: "Sass At Home: Che Calor - Major Lazer/J Balvin"),
        Combo(title: "Sass At Home: Gum Body - Jorja Smith/Burna Boy"),
        Combo(title: "Sass At Home: Calypso - Luis Fonsi & Stefflon Don"),
        Combo(title: "Sass At Home: Mad At Me - Kiana Lede"),
    ]
}

// MARK: Life Cycle Methods
extension PlaylistViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        tableView.dataSource = self
        title = "Intervals"
    }
}

extension PlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        combos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = combos[indexPath.row].title
        return cell
    }
}
