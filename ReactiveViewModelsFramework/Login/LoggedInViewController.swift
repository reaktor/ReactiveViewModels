import UIKit
import Cartography

class LoggedInViewController: UIViewController {
    override func viewDidLoad() {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 96.0)
        label.text = "👍😄👍"
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        constrain (view, label) { s, label in
            label.center == s.center
        }
    }
}

