import Foundation

struct APIManager {
    
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }
}

extension APIManager {
    
    func fetchStarred(_ completion: @escaping (Result<[Starred], APIError>) -> ()) {
        guard let url = APIEndpoint.starred.url else {
            completion(.failure(.failedURLCreation))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let starred = try JSONDecoder().decode([Starred].self, from: data)
                        completion(.success(starred))
                    } catch {
                        completion(.failure(.unexpectedDataFormat))
                    }
                } else {
                    completion(.failure(.failedRequest))
                }
            }
        }.resume()
    }
    
    func fetchRepositories(_ completion: @escaping (Result<[Repository], APIError>) -> ()) {
        guard let url = APIEndpoint.starred.url else {
            completion(.failure(.failedURLCreation))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let repos = try JSONDecoder().decode([Repository].self, from: data)
                        completion(.success(repos))
                    } catch {
                        completion(.failure(.unexpectedDataFormat))
                    }
                } else {
                    completion(.failure(.failedRequest))
                }
            }
        }.resume()
    }
}
