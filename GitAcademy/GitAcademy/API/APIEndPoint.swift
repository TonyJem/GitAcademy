import Foundation

enum APIEndpoint {
    case user
    case repositories
    case starred
    
    var url: URL? {
        switch self {
        case .user:
          return makeURL(endpoint: "_")
        case .repositories:
          return makeURL(endpoint: "_")
        case .starred:
            guard let username = Core.accountManager.username else { return nil }
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
