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
            userDefaults.string(forKey: UserDefaultsKey.accessToken)
        }
        set {
            userDefaults.setValue(newValue, forKey: UserDefaultsKey.accessToken)
        }
    }
    
    var refreshToken: String? {
        get {
            userDefaults.string(forKey: UserDefaultsKey.refreshToken)
        }
        set {
            userDefaults.setValue(newValue, forKey: UserDefaultsKey.refreshToken)
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
    
    private func savePassword(_ password: String, username: String) {
        keyChain.set(password, forKey: username)
    }
    
    private func getPassword(username: String) -> String? {
        keyChain.get(username)
    }
}
