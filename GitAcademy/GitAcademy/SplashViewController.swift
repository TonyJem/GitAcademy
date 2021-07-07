import UIKit

class SplashViewController: UIViewController {
    
    private let indicatorAlpha: CGFloat = 0.4
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let loginVC = LoginViewController()
    private let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: .zero, alpha: indicatorAlpha)
        
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(.zero)) { [self] in
            activityIndicator.stopAnimating()
            Core.accountManager.userIsLoggedIn ? show(profileVC) : show(loginVC)
        }
    }
    
    private func show(_ controller: UIViewController) {
        SceneDelegate.shared.rootViewController.show(controller)
    }
}
