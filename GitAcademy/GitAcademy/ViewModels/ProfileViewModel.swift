// WHY?: Should we count only user's starred, or starred in where are included other stargazers also ?
import AuthenticationServices

class ProfileViewModel: NSObject {
    // TODO: Create progress indicator
    private var isLoading = false
    
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
                        print("🟢 fetchUser success!")
                        self.profile.user = networkResponse.object
                        
                        // TODO: Remove getting repositories list to independent thread
                        self.fetchRepositories()
                    }
                case .failure(let error):
                    print("🔴 Failed to get user, or there is no valid/active session: \(error.localizedDescription)")
                }
                self.isLoading = false
            }
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
                        print("🟢🟢 fetchRepositories success !")
                        self.profile.repositories = networkResponse.object
                        self.profile.starredRepositories = networkResponse.object.filter { $0.stargazers_count > 0 }
                        Core.accountManager.profile = self.profile
                        SceneDelegate.shared.rootViewController.navigateToMainScreen()
                    }
                case .failure(let error):
                    print("🔴 Failed to get the user's repositories: \(error)")
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
