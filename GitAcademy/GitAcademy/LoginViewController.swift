import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private weak var loginButton: UIButton!
    
    private var viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = loginButton.frame.height/2
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        print("🟢 LoginButton Did Tap")
        viewModel.signInDidTap()
    }
}
