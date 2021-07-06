import Foundation

// TODO: Change snake case to normal Swift Names
struct User: Decodable, Encodable {
    var avatar_url: String
// TODO: rename "login" to "username" and make sure it is consitent everywhere
    var login: String
    var name: String?
    var followers: Int
    var following: Int
    var public_repos: Int
}
