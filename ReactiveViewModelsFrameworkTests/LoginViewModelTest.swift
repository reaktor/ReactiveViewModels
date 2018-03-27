import XCTest
import RxSwift
import RxCocoa
@testable import ReactiveViewModelsFramework

class LoginViewModelTest: XCTestCase {
    var driver: LoginViewModelDriver!
    var disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        driver = LoginViewModelDriver()
    }

    override func tearDown() {
        driver = nil
        disposeBag = DisposeBag()
        super.tearDown()
    }

    var viewModel: LoginViewModel {
        return driver.viewModel
    }

    func testIsUsernameEnabled_initialValue() {
        let isUsernameEnabledRelay = BehaviorRelay<Bool?>(value: nil)
        viewModel.isUsernameEnabled.bind(to: isUsernameEnabledRelay).disposed(by: disposeBag)
        XCTAssertEqual(isUsernameEnabledRelay.value, .some(true))
    }

    func testSuccessfulLogin() {
        let loginCredentialsRelay = BehaviorRelay<Credentials?>(value: nil)
        let loginResultRelay = BehaviorRelay<LoginResult?>(value: nil)

        driver.testLoginApi.loginCredentialsRelay.bind(to: loginCredentialsRelay).disposed(by: disposeBag)
        viewModel.loginResult.bind(to: loginResultRelay).disposed(by: disposeBag)

        driver.usernameSubject.onNext("simon")
        driver.passwordSubject.onNext("letmein")
        driver.loginPressedSubject.onNext(())
        XCTAssertEqual(loginCredentialsRelay.value, .some(Credentials(username: "simon", password: "letmein")))
        driver.testLoginApi.loginResultRelay.accept(.success)
        XCTAssertEqual(loginResultRelay.value, .some(.success))
    }

    func testFailedLogin() {
        let loginCredentialsRelay = BehaviorRelay<Credentials?>(value: nil)
        let loginResultRelay = BehaviorRelay<LoginResult?>(value: nil)

        driver.testLoginApi.loginCredentialsRelay.bind(to: loginCredentialsRelay).disposed(by: disposeBag)
        viewModel.loginResult.bind(to: loginResultRelay).disposed(by: disposeBag)

        driver.usernameSubject.onNext("adversary")
        driver.passwordSubject.onNext("abc123")
        driver.loginPressedSubject.onNext(())
        XCTAssertEqual(loginCredentialsRelay.value, .some(Credentials(username: "adversary", password: "abc123")))
        driver.testLoginApi.loginResultRelay.accept(.failure)
        XCTAssertEqual(loginResultRelay.value, .some(.failure))
    }
}

class LoginViewModelDriver {
    let usernameSubject = PublishSubject<String?>()
    let passwordSubject = PublishSubject<String?>()
    let loginPressedSubject = PublishSubject<Void>()
    let returnPressedOnPasswordSubject = PublishSubject<Void>()
    let testLoginApi = TestLoginApi()

    let viewModel: LoginViewModel

    init() {
        viewModel = LoginViewModel(username: usernameSubject, password: passwordSubject, loginPressed: loginPressedSubject, returnPressedOnPassword: returnPressedOnPasswordSubject, api: testLoginApi)
    }
}

class TestLoginApi: LoginApiType {
    let loginCredentialsRelay = PublishRelay<Credentials>()
    let loginResultRelay = PublishRelay<LoginResult>()

    func login(credentials: Credentials) -> Observable<LoginResult> {
        loginCredentialsRelay.accept(credentials)
        return loginResultRelay.take(1)
    }
}
