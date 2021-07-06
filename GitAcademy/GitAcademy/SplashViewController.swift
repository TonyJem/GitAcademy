import UIKit

// TODO: Use or remove comments below
// Splash Screen will be the first screen that the user will see when the app is launched.
// This is the best time to do all the service API calls,
// check the user session, trigger pre-login analytics, etc.

class SplashViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        // TODO: Magic numbers
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            self.activityIndicator.stopAnimating()
            
            // TODO: Use KeyChain instead of UserDefaults
            // We definitely don’t want to use the UserDefaults in production
            // to store the user session or any other sensitive information;
            // We only use it to keep it here before implementing KeyChain.
            
            if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
                // TODO: navigate to protected page
            } else {
                // TODO: navigate to login screen
            }
        }
    }
}
