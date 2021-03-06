import Foundation

struct Contributor: Codable {
    var username: String
    var avatarURL: String

    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarURL = "avatar_url"
    }
}
