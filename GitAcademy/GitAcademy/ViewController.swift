import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = loginButton.frame.height/2
    }
    
    @IBAction func loginButtonTap(_ sender: UIButton) {
        print("🟢 LoginButton Did Tap")
    }
}
