//TODO: Remove testAvatar image from assets while not needed

import Foundation

struct Core {
    static var accountManager = AccountManager()
    
//    TODO: Move profile into accountManager
    static var profile = Profile(user: User(avatar_url: "", login: "CoreLog", name: "CoreName", followers: 99, following: 101, public_repos: 199), repositories: [], starredRepositories: [])
}
