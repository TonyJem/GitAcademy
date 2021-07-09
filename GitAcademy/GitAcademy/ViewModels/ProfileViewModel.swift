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
            callbackURLScheme: callbackURLScheme) { callbackURL, error in
            guard error == nil,
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
                    Core.apiManager.fetchUser()
                    self.fetchUserNew()
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
    
    func fetchUserNew() {
        // self.turnActivityIndicatorON()
        Core.apiManager.fetchUserNew { result in
            switch result {
            case .success(let user):
                print("🟢 Newly fetched User is: \(user.username)")
            case .failure(let error):
                print("🔴 \(error)")
            }
            // self.turnActivityIndicatorOFF()
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
