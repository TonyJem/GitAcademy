import UIKit

class InitialViewController: UIViewController {
    
    private let loginVC = LoginViewController()
    private let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Core.accountManager.userIsLoggedIn ? show(profileVC) : show(loginVC)
    }
    
    private func show(_ controller: UIViewController) {
        SceneDelegate.shared.rootViewController.show(controller)
    }
}
