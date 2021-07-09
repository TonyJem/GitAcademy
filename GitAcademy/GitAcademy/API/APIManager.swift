import Foundation

struct APIManager {
    
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }
}

extension APIManager {
    
    func fetchUser() {
        NetworkRequest.RequestType.getUser.networkRequest()?.start(responseType: User.self) { result in
                switch result {
                case .success(let networkResponse):
                    DispatchQueue.main.async {
                        print("🟢 fetchUser success! User name is: \(networkResponse.object.username)")
                    }
                case .failure(let error):
                    print("🔴 Failed to get user, or there is no valid/active session: \(error.localizedDescription)")
                }
            }
    }
    
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
    


    
  /*
    func fetchRepositories() {
        NetworkRequest
            .RequestType
            .getRepos
            .networkRequest()?
            .start(responseType: [Repository].self) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let networkResponse):
                    DispatchQueue.main.async {
                        print("🟢🟢 fetchRepositories success !")
                        self.profile.repositories = networkResponse.object
                        Core.accountManager.profile = self.profile
                        SceneDelegate.shared.rootViewController.navigateToMainScreenAnimated()
                    }
                case .failure(let error):
                    print("🔴 Failed to get the user's repositories: \(error)")
                }
            }
    }
 */
}
