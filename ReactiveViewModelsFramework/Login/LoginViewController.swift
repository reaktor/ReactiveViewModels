import Foundation
import UIKit
import RxSwift
import RxCocoa
import Cartography

public class LoginViewController: UIViewController {
    let loginView = LoginView()
    let viewModel: LoginViewModel
    let viewDidLoadDisposeBag = DisposeBag()

    public init() {
        viewModel = LoginViewModel(username: loginView.usernameField.rx.text.asObservable(), password: loginView.passwordField.rx.text.asObservable(), loginPressed: loginView.loginButton.rx.tap.asObservable(), returnPressedOnPassword: loginView.passwordField.rx.controlEvent(.editingDidEndOnExit).asObservable())
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        view = loginView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Login"

        viewModel.isLoginEnabled
            .bind(to: loginView.loginButton.rx.isEnabled)
            .disposed(by: viewDidLoadDisposeBag)
        viewModel.isUsernameEnabled
            .bind(to: loginView.usernameField.rx.isEnabled)
            .disposed(by: viewDidLoadDisposeBag)
        viewModel.isPasswordEnabled
            .bind(to: loginView.passwordField.rx.isEnabled)
            .disposed(by: viewDidLoadDisposeBag)
        viewModel.isLoginEnabled
            .bind(to: loginView.loginButton.rx.isEnabled)
            .disposed(by: viewDidLoadDisposeBag)
        viewModel.isLoginInProgress
            .bind(to: loginView.activityIndicator.rx.isAnimating)
            .disposed(by: viewDidLoadDisposeBag)
        viewModel.isLoginInProgress
            .bind(to: loginView.loginButton.rx.isHidden)
            .disposed(by: viewDidLoadDisposeBag)
        viewModel.loggedIn
            .bind(to: loggedIn)
            .disposed(by: viewDidLoadDisposeBag)
        viewModel.isIncorrectUsernameOrPasswordHidden
            .bind(to: loginView.incorrectUsernameOrPasswordLabel.rx.isHidden)
            .disposed(by: viewDidLoadDisposeBag)

    }

    var loggedIn: Binder<Void> {
        return Binder(self) { controller, _ in
            let loggedInViewController = LoggedInViewController(nibName: nil, bundle: nil)
            controller.navigationController?.setViewControllers([loggedInViewController], animated: false)
        }
    }
}
