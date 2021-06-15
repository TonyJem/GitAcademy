import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 30
        loginButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func loginButtonTap(_ sender: UIButton) {
        print("🟢 LoginButton Did Tap")
    }
}
