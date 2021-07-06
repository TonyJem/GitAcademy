import Foundation

struct AccountManager {
    
    private enum UserDefaultsKey {
        static let variable1 = "Key1"
        static let variable2 = "Key2"
        static let variable3 = "Key3"
    }
    
    private var keyChain = KeychainSwift()
    private var userDefaults = UserDefaults.standard
    
    var userIsLoggedIn: Bool {
        return userDefaults.bool(forKey: "LOGGED_IN")
    }
    
    func registerLogIn() {
        userDefaults.set(true, forKey: "LOGGED_IN")
    }
    
    func registerLogOut() {
        userDefaults.set(false, forKey: "LOGGED_IN")
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
