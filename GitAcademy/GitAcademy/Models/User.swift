import Foundation

struct User: Codable {
    var avatar: String
// TODO: rename "login" to "username" and make sure it is consitent everywhere
    var login: String
    var name: String?
    var followers: Int
    var following: Int
    var public_repos: Int
    
    enum CodingKeys: String, CodingKey {
        case avatar = "avatar_url"
    // TODO: rename "login" to "username" and make sure it is consitent everywhere
        case login
        case name
        case followers
        case following
        case public_repos
    }
}
