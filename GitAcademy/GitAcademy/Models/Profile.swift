import Foundation

struct Profile: Codable {
    var user: User
    var repositories: [Repository]
    var starredRepositories: [Repository]
}
