import Foundation

struct User: Codable {
    var avatar: String
    var username: String
    var name: String?
    var followers: Int
    var following: Int
    
    enum CodingKeys: String, CodingKey {
        case avatar = "avatar_url"
        case username = "login"
        case name
        case followers
        case following
    }
}
