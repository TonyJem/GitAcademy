import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private weak var loginButton: UIButton!
    
    private let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
    
    private var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.roundCorners()
    }
    
    func presentProfileViewController() {
        self.present(profileViewController, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        print("🟢 LoginButton Did Tap")
        
        // TODO: store the user session (example only, not for the production)
        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        // TODO: navigate to the Main Screen
        SceneDelegate.shared.rootViewController.switchToMainScreen()
        
        // TODO: Enable normal login functionality
        // viewModel.login()
    }
}
