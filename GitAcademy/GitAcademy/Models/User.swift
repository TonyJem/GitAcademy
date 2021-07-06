import Foundation

//TODO: Change snake case to normal Swift Names
struct User: Decodable {
    var avatar_url: String
    var login: String
    var name: String?
    var followers: Int
    var following: Int
    var public_repos: Int
}
