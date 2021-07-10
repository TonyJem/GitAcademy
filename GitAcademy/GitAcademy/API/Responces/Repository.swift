import Foundation

struct Repository: Codable, Identifiable {
    var id: Int
    var name: String
    var description: String?
    var stargazersCount: Int
    var owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case stargazersCount = "stargazers_count"
        case owner
    }
}
