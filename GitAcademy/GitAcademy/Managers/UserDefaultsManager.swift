import Foundation

struct UserDefaultsManager {
    
    private enum UserDefaultsManagerKey {
        static let variable1 = "Key1"
        static let variable2 = "Key2"
        static let variable3 = "Key3"
    }
    
    private static var userDefaults: UserDefaults {
        UserDefaults.standard
    }
    
    private static var keyChain: KeychainSwift {
        KeychainSwift()
    }
}


// MARK: - keyChain Methods
extension UserDefaultsManager {
    
    private static func savePassword(_ password: String, username: String) {
        keyChain.set(password, forKey: username)
    }
    
    static func getPassword(username: String) -> String? {
        keyChain.get(username)
    }
}
