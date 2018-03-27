struct Credentials {
    let username: String
    let password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    init?(username: String?, password: String?) {
        guard let username = username, let password = password else {
            return nil
        }
        self = Credentials(username: username, password: password)
    }

    var hasNonEmptyValues: Bool {
        return !username.isEmpty && !password.isEmpty
    }
}

extension Credentials: Equatable {
    static func ==(lhs: Credentials, rhs: Credentials) -> Bool {
        return lhs.username == rhs.username && lhs.password == rhs.password
    }
}

enum LoginResult {
    case success, failure
}
