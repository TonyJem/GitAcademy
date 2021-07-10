import AuthenticationServices

class ProfileViewModel: NSObject {
    
    // TODO: May be move profile to init, to start it with data already fetched
    private var profile = Profile(user: User(avatar: "", username: "", name: "", followers: 0, following: 0),
                                  repositories: [], starredRepositories: [])
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
            
            networkRequest.start(responseType: String.self) { result in
                switch result {
                case .success:
                    self.fetchUser()
                case .failure(let error):
                    print("🔴 Failed to exchange access code for tokens: \(error)")
                }
            }
        }
        
        authenticationSession.presentationContextProvider = self
        authenticationSession.prefersEphemeralWebBrowserSession = true
        
        if !authenticationSession.start() {
            print("🔴 Failed to start ASWebAuthenticationSession")
        }
    }
}

//MARK: - Private
private extension ProfileViewModel {
    func fetchUser() {
        NetworkRequest.RequestType.getUser.networkRequest()?.start(responseType: User.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let networkResponse):
                DispatchQueue.main.async {
                    print("🟢 Fetch User success !")
                    print("🟢 Username: \(networkResponse.object.username)")
                    self.profile.user = networkResponse.object
                    Core.accountManager.profile = self.profile
                    self.fetchRepositories()
                }
            case .failure(let error):
                print("🔴 Failed to get user, or there is no valid/active session: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchRepositories() {
        Core.apiManager.fetchRepositories { result in
            switch result {
            case .success(let repos):
                print("🟢🟢 Fetch Repositories success !")
                print("🟢🟢 Repositories count: \(repos.count)")
                
                print("🟢🟢 1st Repo Owner's Username: \(repos[0].owner.username)")
                print("🟢🟢 1st Repo Owner's AvatarURL: \(repos[0].owner.avatarURL)")
                print("🟢🟢 1st Repo Name: \(String(describing: repos[0].name))")
                print("🟢🟢 1st Repo Description: \(String(describing: repos[0].description))")
                print("🟢🟢 1st Repo Stars: \(repos[0].stargazersCount)")
                print("🟢🟢 1st Repo Language: \(String(describing: repos[0].language))")
                
                Core.accountManager.profile?.repositories = repos
                self.fetchContibutors(for: repos[0])
                
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
    
    func fetchContibutors(for repo: Repository) {
        Core.apiManager.fetchContributors(for: repo, { result in
            switch result {
            case .success(let contributors):
                print("🟣 Fetch Contributors success !")
                print("🟣 Contributors count: \(contributors.count)")
                print("🟣 1st contibutor description: \(contributors[0].username)")
                
                self.fetchStarred()
            case .failure(let error):
                print("🔴 \(error)")
            }
        })
    }
    
    func fetchStarred() {
        Core.apiManager.fetchStarred { result in
            switch result {
            case .success(let starred):
                print("🟢🟢🟢 Fetch Starred success !")
                print("🟢🟢🟢 Starred count: \(starred.count)")
                print("🟢🟢🟢 1st Starred description: \(starred[0].description)")
                Core.accountManager.profile?.starredRepositories = starred
                SceneDelegate.shared.rootViewController.navigateToMainScreenAnimated()
            case .failure(let error):
                print("🔴 \(error)")
            }
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
