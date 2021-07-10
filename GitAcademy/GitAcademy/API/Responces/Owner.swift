import Foundation

struct Owner: Codable {
    var username: String
    var avatar: String
    

    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatar = "avatar_url"
    }
}
