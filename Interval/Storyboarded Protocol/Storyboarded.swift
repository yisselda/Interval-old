import UIKit

protocol Storyboarded {
  static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
  static func instantiate() -> Self {
    let storyboard = UIStoryboard(name: "Main", bundle: .main)
    let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
    if #available(iOS 13.0, *) {
      vc.modalPresentationStyle = .fullScreen
    }
    
    return vc
  }
}
