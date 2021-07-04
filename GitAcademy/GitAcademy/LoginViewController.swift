import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private weak var loginButton: UIButton!
    
    private var viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = loginButton.frame.height/2
    }
    
    func performSegue() {
        performSegue(withIdentifier: "showDetailsViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetailsViewController") {
            print("🟢🟢🟢🟢 Segue prepared ok")
//            let destinationVC = segue.destination as! DetailsViewController
//            destinationVC.flickrImage = image(for: selectedIndexPath)
        }
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        print("🟢 LoginButton Did Tap")
        viewModel.signInDidTap()
    }
}
