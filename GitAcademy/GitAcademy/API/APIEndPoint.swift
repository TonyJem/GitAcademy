// selected User's Starred repos:
// https://api.github.com/users/tonyjem/starred

// selected User's, selected repos's conributors:
// https://api.github.com/repos/tonyjem/02Lecture-Protocols/contributors

import Foundation

enum APIEndpoint {
    case repositories
    case starred
    case contributors
    
    var url: URL? {
        
        guard let username = Core.accountManager.username,
              !username.isEmpty else {
            return nil
        }
        
        // TODO: Implement Logic to go throught all pages and count all repositories
        let queryItems = [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "per_page", value: "100")
        ]
        
        switch self {
        case .repositories:
            return makeURL(endpoint: "users/\(username)/repos", queryItems: queryItems)
        case .starred:
            return makeURL(endpoint: "users/\(username)/starred", queryItems: queryItems)
        case .contributors:
            return makeURL(endpoint: "repos/\(username)/02Lecture-Protocols/contributors", queryItems: queryItems)
        }
    }
}

private extension APIEndpoint {
    var BaseURL: String {
        "https://api.github.com/"
    }
    
    func makeURL(endpoint: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        let urlString = BaseURL + endpoint
        
        guard let queryItems = queryItems else {
            return URL(string: urlString)
        }
        
        var components = URLComponents(string: urlString)
        components?.queryItems = queryItems
        return components?.url
    }
}
