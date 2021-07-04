import AuthenticationServices

class SignInViewModel: NSObject {
    private var isShowingRepositoriesView = false
    private var isLoading = false
    
// TODO: Remove repositories, while start using RepositoriesViewModel
    var repositories: [Repository] = []
    
    func signInDidTap() {
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
                    self.getUser()
                    print("🟢 getUser success!")
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
    
    /* TODO: Find out if need it: in case yes - use it; no - delete this block
     func appeared() {
     // Try to get the user in case the tokens are already stored on this device
     getUser()
     }
     */
    
}

//MARK: - Private
private extension SignInViewModel {
    func getUser() {
        isLoading = true
        
        NetworkRequest
            .RequestType
            .getUser
            .networkRequest()?
            .start(responseType: User.self) { [weak self] result in
                switch result {
                case .success:
                    self?.isShowingRepositoriesView = true
                    print("🟢 Start Loading repositorias...")
                    
                    self?.loadRepositories()
                    
                    
                case .failure(let error):
                    print("🔴 Failed to get user, or there is no valid/active session: \(error.localizedDescription)")
                }
                self?.isLoading = false
            }
    }
    
    // TODO: Remove loadRepositories(), while start using RepositoriesViewModel
    func loadRepositories() {
        NetworkRequest
            .RequestType
            .getRepos
            .networkRequest()?
            .start(responseType: [Repository].self) { [weak self] result in
                switch result {
                case .success(let networkResponse):
                    DispatchQueue.main.async {
                        self?.repositories = networkResponse.object
                        print("🟢🟢 Repositorias loaded with Success!")
                        self?.printRepositoriasNames()
                        self?.perfomSegue()
                    }
                case .failure(let error):
                    print("🔴 Failed to get the user's repositories: \(error)")
                }
            }
    }
    
    // TODO: Remove while not necessary for tests
    func printRepositoriasNames() {
        print("🟢🟢🟢 Start Printing repositorias...")
        
        for (index, repositoria) in repositories.enumerated() {
            print("🟣 \(index) 👍 \(repositoria.id) Repositoria \(repositoria.name)")
        }
    }
    
    // TODO: Remove perfomSegue(), while start using RepositoriesViewModel
    func perfomSegue() {
        if let loginViewContoller = UIApplication.topMostViewController() as? LoginViewController {
            loginViewContoller.performSegue(withIdentifier: "showDetailsViewController", sender: nil)
        }
    }
}

//MARK: - AuthenticationServices
extension SignInViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession)
    -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}
