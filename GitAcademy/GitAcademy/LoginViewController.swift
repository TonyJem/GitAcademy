import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private weak var loginButton: UIButton!
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.roundCorners()
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        print("🟢 LoginButton Did Tap")
        viewModel.login()
    }
}
