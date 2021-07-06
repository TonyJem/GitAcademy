import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Current background To visually distinguish the protected part
        view.backgroundColor = UIColor.green
        title = "Main Screen"
        let logoutButton = UIBarButtonItem(
            title: "Log Out", style: .plain,
            target: self, action: #selector(logout))
        navigationItem.setLeftBarButton(logoutButton, animated: true)
    }
    
    @objc private func logout() {
        // TODO: Clear the user session (example only, not for the production)
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        // TODO: Navigate to login screen
        SceneDelegate.shared.rootViewController.switchToLogout()
    }
}
