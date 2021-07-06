import Foundation

struct AccountManager {
    
    private enum UserDefaultsKey {
        static let loggedInState = "LOGGED_IN"
        static let username = "username"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }
    
    private var keyChain = KeychainSwift()
    private var userDefaults = UserDefaults.standard
    
    var userIsLoggedIn: Bool {
        return userDefaults.bool(forKey: UserDefaultsKey.loggedInState)
    }
    
    var username: String? {
        get {
            userDefaults.string(forKey: UserDefaultsKey.username)
        }
        set {
            userDefaults.setValue(newValue, forKey: UserDefaultsKey.username)
        }
    }
    
    var accessToken: String? {
        get {
            fromKeyChain(UserDefaultsKey.accessToken)
        }
        set {
            let token = newValue != nil ? newValue! : ""
            toKeyChain(token, for: UserDefaultsKey.accessToken)
        }
    }
    
    var refreshToken: String? {
        get {
            fromKeyChain(UserDefaultsKey.refreshToken)
        }
        set {
            let token = newValue != nil ? newValue! : ""
            toKeyChain(token, for: UserDefaultsKey.refreshToken)
        }
    }
    
    func registerLogIn() {
        userDefaults.set(true, forKey: UserDefaultsKey.loggedInState)
    }
    
    func registerLogOut() {
        userDefaults.set(false, forKey: UserDefaultsKey.loggedInState)
    }
}

// MARK: - keyChain Methods
private extension AccountManager {
    private func toKeyChain(_ token: String, for key: String) {
        keyChain.set(token, forKey: key)
    }
    
    private func fromKeyChain(_ key: String) -> String? {
        keyChain.get(key)
    }
}
