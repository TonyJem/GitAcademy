import Foundation

struct Starred: Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case stargazersCount = "stargazers_count"
    }
}
