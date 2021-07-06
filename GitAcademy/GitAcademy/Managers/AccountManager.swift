import Foundation

struct AccountManager {
    
    private enum UserDefaultsKey {
        static let loggedInState = "loggedIn"
        static let username = "username"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let profile = "profile"
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
            var token = ""
            if let unwrappedValue = newValue {
                token = unwrappedValue
            }
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
    
    var profile: Profile? {
        get {
            guard let profile = userDefaults.object(forKey: UserDefaultsKey.profile) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode(Profile.self, from: profile)
        } set {
            print("Set user login 🟢 \(String(describing: newValue?.user.login))")
            let profile = try? JSONEncoder().encode(newValue)
            print("🟢 Profile DATA:\(String(describing: profile))")
            userDefaults.set(profile, forKey: UserDefaultsKey.profile)
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
