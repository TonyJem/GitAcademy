import AuthenticationServices

class LoginViewModel: NSObject {
    
    // TODO: May be move profile to init, to start it with data already fetched
    private var profile = Profile(user: User(username: "", avatar: "", name: "", publicReposCount: 0, followers: 0, following: 0),
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
                case .success(let answer):
                    let object = answer.object
                    print("🟣🟣🟣 Object: \(object)")
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
private extension LoginViewModel {
    func fetchUser() {
        NetworkRequest.RequestType.getUser.networkRequest()?.start(responseType: User.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let networkResponse):
                DispatchQueue.main.async {
                    print("🟢 Fetch User success !")
                    print("🟢 Username: \(networkResponse.object.username)")
                    print("🟢 Username PublicRepos count: \(networkResponse.object.publicReposCount)")
                    self.profile.user = networkResponse.object
                    Core.accountManager.profile = self.profile
                    SceneDelegate.shared.rootViewController.navigateToMainScreenAnimated()
                    
                }
            case .failure(let error):
                print("🔴 Failed to get user, or there is no valid/active session: \(error.localizedDescription)")
            }
        }
    }
}

//MARK: - AuthenticationServices
extension LoginViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession)
    -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}
