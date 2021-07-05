import Foundation

struct Repository: Decodable, Identifiable {
    var id: Int
    var name: String
    var stargazers_count: Int
}
