import Foundation

struct AccountManager {
    
    private enum UserDefaultsKey {
        // TODO: Decide if should keep username sepratelly or it can be used from Profile model?
        static let username = "username"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let profile = "profile"
    }
    
    private var keyChain = KeychainSwift()
    private var userDefaults = UserDefaults.standard
    
    var userIsLoggedIn: Bool {
        return Core.accountManager.username != nil
    }
    
    var profile: Profile? {
        get {
            guard let profile = userDefaults.object(forKey: UserDefaultsKey.profile) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode(Profile.self, from: profile)
        } set {
            let profile = try? JSONEncoder().encode(newValue)
            userDefaults.set(profile, forKey: UserDefaultsKey.profile)
        }
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

    func cleanCredentials() {
        Core.accountManager.profile = nil
        Core.accountManager.username = nil
        Core.accountManager.accessToken = nil
        Core.accountManager.refreshToken = nil
    }
}

// MARK: - KeyChain Methods
private extension AccountManager {
    private func toKeyChain(_ token: String, for key: String) {
        keyChain.set(token, forKey: key)
    }
    
    private func fromKeyChain(_ key: String) -> String? {
        keyChain.get(key)
    }
}
