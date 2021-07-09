import Foundation

struct Repository: Codable, Identifiable {
    var id: Int
    var name: String
    var stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case stargazersCount = "stargazers_count"
    }
}
