import Foundation

struct User: Codable {
    var username: String
    var avatar: String
    var name: String?
    var publicReposCount: Int
    var followers: Int
    var following: Int
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatar = "avatar_url"
        case name
        case publicReposCount = "public_repos"
        case followers
        case following
    }
}
