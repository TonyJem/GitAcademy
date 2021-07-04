import Foundation

class RepositoriesViewModel: ObservableObject {
    @Published private(set) var repositories: [Repository]
    let username: String
    
    init() {
        self.repositories = []
        self.username = NetworkRequest.username ?? ""
    }
    
    private init(
        repositories: [Repository],
        username: String
    ) {
        self.repositories = repositories
        self.username = username
    }
    
    func load() {
        NetworkRequest
            .RequestType
            .getRepos
            .networkRequest()?
            .start(responseType: [Repository].self) { [weak self] result in
                switch result {
                case .success(let networkResponse):
                    DispatchQueue.main.async {
                        self?.repositories = networkResponse.object
                    }
                case .failure(let error):
                    print("Failed to get the user's repositories: \(error)")
                }
            }
    }
    
    func signOut() {
        NetworkRequest.signOut()
    }
    
    static func preview() -> RepositoriesViewModel {
        let repositories: [Repository] = [
            Repository(id: 1, name: "First"),
            Repository(id: 2, name: "Second"),
            Repository(id: 3, name: "Third")
        ]
        
        return RepositoriesViewModel(
            repositories: repositories,
            username: "GitHub user")
    }
}
