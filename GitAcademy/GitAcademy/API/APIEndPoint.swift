// selected User Starred repos:
// https://api.github.com/users/tonyjem/starred

import Foundation

enum APIEndpoint {
    case repositories
    case starred
    
    var url: URL? {
        guard let username = Core.accountManager.username else { return nil }
        switch self {
        case .repositories:
          return makeURL(endpoint: "users/\(username)/repos")
        case .starred:
            return makeURL(endpoint: "users/\(username)/starred")
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
