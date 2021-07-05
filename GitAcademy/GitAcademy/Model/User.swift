import Foundation

struct User: Decodable {
    var avatar_url: String
    var login: String
    var name: String?
}
