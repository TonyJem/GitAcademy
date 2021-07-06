import Foundation

struct AccountManager {
    
    private enum UserDefaultsKey {
        static let loggedInState = "LOGGED_IN"
    }
    
    private var keyChain = KeychainSwift()
    private var userDefaults = UserDefaults.standard
    
    var userIsLoggedIn: Bool {
        return userDefaults.bool(forKey: UserDefaultsKey.loggedInState)
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
