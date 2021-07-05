import AuthenticationServices

class ProfileViewModel: NSObject {
    // TODO: Create progress indicator
    private var isLoading = false
    
    private var user: User?
    private var repositories: [Repository] = []
    private var starredRepositories: [Repository] = []
    
    func login() {
        guard let signInURL = NetworkRequest.RequestType.signIn.networkRequest()?.url else {
            print("🔴 Could not create the sign in URL .")
            return
        }
        
        let callbackURLScheme = NetworkRequest.callbackURLScheme
        let authenticationSession = ASWebAuthenticationSession(
            url: signInURL,
            callbackURLScheme: callbackURLScheme) { [weak self] callbackURL, error in
            guard error == nil,
                  let self = self,
                  let callbackURL = callbackURL,
                  let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
                  let code = queryItems.first(where: { $0.name == "code" })?.value,
                  let networkRequest = NetworkRequest.RequestType.codeExchange(code: code).networkRequest()
            else {
                print("🔴 An error occurred when attempting to sign in.")
                return
            }
            
            self.isLoading = true
            networkRequest.start(responseType: String.self) { result in
                switch result {
                case .success:
                    self.fetchUser()
                case .failure(let error):
                    print("🔴 Failed to exchange access code for tokens: \(error)")
                    self.isLoading = false
                }
            }
        }
        
        authenticationSession.presentationContextProvider = self
        authenticationSession.prefersEphemeralWebBrowserSession = true
        
        if !authenticationSession.start() {
            print("🔴 Failed to start ASWebAuthenticationSession")
        }
    }
    
    /* TODO: Find out if need to get user without fetching token it: in case yes - use it; no - delete this block
     func appeared() {
     // Try to get the user in case the tokens are already stored on this device
     getUser()
     }
     */
    
}

//MARK: - Private
private extension ProfileViewModel {
    func fetchUser() {
        isLoading = true
        
        NetworkRequest
            .RequestType
            .getUser
            .networkRequest()?
            .start(responseType: User.self) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let networkResponse):
                    DispatchQueue.main.async {
                        self.user = networkResponse.object
                        print("🟢 fetchUser success!")
                        self.printUserDetails()
                        // TODO: Remove getting repositories list to independent thread
                        self.fetchRepositories()
                    }
                case .failure(let error):
                    print("🔴 Failed to get user, or there is no valid/active session: \(error.localizedDescription)")
                }
                self.isLoading = false
            }
    }
    
    // TODO: Remove while is not neccesary
    func printUserDetails() {
        guard let user = user  else { return }
        print("🟣 Avatar_URL: \(user.avatar_url)")
        
        if let name = user.name {
            print("🟣 Name: \(name)")
        } else {
            print("🟣 Name: ''")
        }
        
        print("🟣 Username: \(user.login)")
        
        print("🟣 Followers: \(user.followers)")
        
        print("🟣 Following: \(user.following)")
        
        print("🟣 Public Repos: \(user.public_repos)")
        
        Core.profile.user = user
        print("🟡 Login from Core: \(Core.profile.user.login)")
    }
    
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
                        self.repositories = networkResponse.object
                        print("🟢🟢 fetchRepositories success !")
                        self.printRepositoriesDetails()
                        self.presentProfileViewController()
                    }
                case .failure(let error):
                    print("🔴 Failed to get the user's repositories: \(error)")
                }
            }
    }
    
    // TODO: Remove while is not neccesary
    func printRepositoriesDetails() {
        print("🟣🟣 Repositories Count: \(repositories.count)")
        
        starredRepositories = repositories.filter { $0.stargazers_count > 0 }
        print("🟣🟣 StarredRepositories Count: \(starredRepositories.count)")
        
        // WHY?: Should count only user's starred, or starred in where are included other stargazers also ?
//        for (index, repo) in starredRepositories.enumerated() {
//            print("🟣\(index)🟣 Name: \(repo.name) 🟣 Stars: \(repo.stargazers_count)")
//        }
        
        Core.profile.repositories = repositories
        Core.profile.starredRepositories = starredRepositories
    }
    
    func presentProfileViewController() {
        if let loginViewContoller = UIApplication.topMostViewController() as? LoginViewController {
            loginViewContoller.presentProfileViewController()
        }
    }
}

//MARK: - AuthenticationServices
extension ProfileViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession)
    -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}
