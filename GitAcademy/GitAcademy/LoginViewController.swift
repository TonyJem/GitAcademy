import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private weak var loginButton: UIButton!
    
    private let viewModel = ProfileViewModel()
    private let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.roundCorners()
    }
    
    func presentProfileViewController() {
        self.present(profileViewController, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        print("🟢 LoginButton Did Tap")
        viewModel.login()
    }
}
