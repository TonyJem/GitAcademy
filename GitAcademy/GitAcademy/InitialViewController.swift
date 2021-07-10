import UIKit

class InitialViewController: UIViewController {
    
    private let loginVC = LoginViewController()
    private let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Core.accountManager.profile?.user {
            profileVC.user = user
        }
        
        Core.accountManager.userIsLoggedIn ? show(profileVC) : show(loginVC)
    }
    
    private func show(_ controller: UIViewController) {
        SceneDelegate.shared.rootViewController.show(controller)
    }
}
