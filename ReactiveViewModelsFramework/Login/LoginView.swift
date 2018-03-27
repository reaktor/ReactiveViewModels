import UIKit
import Cartography

class LoginView: UIView {
    let usernameField: UITextField = {
        let result = UITextField(frame: .zero)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.placeholder = "Username"
        result.borderStyle = UITextBorderStyle.roundedRect
        result.autocorrectionType = .no
        result.autocapitalizationType = .none
        result.returnKeyType = .next
        return result
    }()

    let passwordField: UITextField = {
        let result = UITextField(frame: .zero)
        result.isSecureTextEntry = true
        result.textContentType = .password
        result.placeholder = "Password"
        result.borderStyle = UITextBorderStyle.roundedRect
        result.returnKeyType = .done
        return result
    }()

    let loginButton: UIButton = {
        let result = UIButton(type: .roundedRect)
        result.setTitle("Login", for: .normal)
        return result
    }()

    let activityIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView(activityIndicatorStyle: .gray)
    }()

    let incorrectUsernameOrPasswordLabel: UILabel = {
        let result = UILabel(frame: .zero)
        result.text = "Incorrect username or password ☹️"
        result.textAlignment = .center
        return result
    }()

    init() {
        super.init(frame: .zero)

        let stackView = UIStackView(arrangedSubviews: [usernameField, passwordField, incorrectUsernameOrPasswordLabel, loginButton, activityIndicator])
        stackView.axis = .vertical
        stackView.spacing = 10.0

        addSubview(stackView)

        constrain(self, stackView) { s, stackView in
            stackView.leading == s.leading + 48
            stackView.trailing == s.trailing - 48
            stackView.centerY == s.centerY
        }

        constrain(usernameField) { $0.height >= 48.0 }
        constrain(passwordField) { $0.height >= 48.0 }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
