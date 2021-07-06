import UIKit

class RootLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        title = "Login Screen"
        let loginButton = UIBarButtonItem(
            title: "Log In", style: .plain,
            target: self, action: #selector(login))
        navigationItem.setLeftBarButton(loginButton, animated: true)
    }
    
    @objc private func login() {
        // TODO: store the user session (example only, not for the production)
        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        // TODO: navigate to the Main Screen
        SceneDelegate.shared.rootViewController.switchToMainScreen()
    }
}
