import Foundation

struct Profile: Decodable, Encodable {
    var user: User
    var repositories: [Repository]
    var starredRepositories: [Repository]
}
