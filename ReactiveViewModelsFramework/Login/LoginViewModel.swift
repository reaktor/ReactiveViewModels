import RxSwift

class LoginViewModel {
    let isUsernameEnabled: Observable<Bool>
    let isPasswordEnabled: Observable<Bool>
    let isLoginEnabled: Observable<Bool>
    let isLoginInProgress: Observable<Bool>
    let loginResult: Observable<LoginResult>
    let isIncorrectUsernameOrPasswordHidden: Observable<Bool>
    let loggedIn: Observable<Void>

    init(username: Observable<String?>, password: Observable<String?>, loginPressed: Observable<Void>,  returnPressedOnPassword: Observable<Void>, api: LoginApiType = LoginApi.instance) {
        let credentials = Observable.combineLatest(username, password)
            .flatMap { (username, password) -> Observable<Credentials> in
                return Observable.from(optional: Credentials(username: username, password: password))
            }
            .share(replay: 1, scope: .whileConnected)

        let hasNonEmptyCredentials = credentials
            .map { $0.hasNonEmptyValues }
            .startWith(false)

        let startLogin = Observable.merge([loginPressed, returnPressedOnPassword])

        loginResult = startLogin
            .withLatestFrom(credentials)
            .flatMapLatest(api.login)
            .share(replay: 1, scope: .whileConnected)

        isLoginEnabled = Observable
            .merge([
                hasNonEmptyCredentials,
                loginResult.map { $0 == .failure },
                startLogin.map(to: false)
                ])

        let credentialsInputEnabled = Observable.merge([
            startLogin.map(to: false),
            loginResult.map { $0 == .failure }
            ]).startWith(true)

        isUsernameEnabled = credentialsInputEnabled
        isPasswordEnabled = credentialsInputEnabled

        isLoginInProgress = Observable.merge([
            startLogin.map(to: true),
            loginResult.map(to: false)
            ])

        isIncorrectUsernameOrPasswordHidden = Observable
            .merge([
                loginResult.map { $0 != .failure },
                startLogin.map(to: true)
                ])
            .startWith(true)

        loggedIn = loginResult
            .filter { $0 == .success}
            .map(to: ())
    }
}
