import RxSwift

protocol LoginApiType {
    func login(credentials: Credentials) -> Observable<LoginResult>
}

class LoginApi: LoginApiType {
    static let instance = LoginApi()

    func login(credentials: Credentials) -> Observable<LoginResult> {
        return Observable<Int>
            .timer(2.0, scheduler: MainScheduler.instance)
            .map { _ in
                if credentials.username == "simon" &&
                    credentials.password == "letmein" {
                    return LoginResult.success
                } else {
                    return LoginResult.failure
                }
        }
    }
}

