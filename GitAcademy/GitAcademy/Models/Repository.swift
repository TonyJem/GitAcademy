import Foundation

//TODO: Change snake case to normal Swift Names
struct Repository: Decodable, Identifiable {
    var id: Int
    var name: String
    var stargazers_count: Int
}
