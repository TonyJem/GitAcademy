import UIKit

class RootViewController: UIViewController {
    
    private let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
    private let profileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
    private let transitionDuration = 0.75
    
    private var current: UIViewController
    
    init() {
        self.current = InitialViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("🔴 init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    func show(_ controller: UIViewController) {
        let new = UINavigationController(rootViewController: controller)
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    
    func navigateToMainScreenAnimated() {
        let mainScreen = UINavigationController(rootViewController: profileViewController)
        Core.accountManager.logIn()
        animateFadeTransition(to: mainScreen)
    }
    
    func navigateToLoginScreenAnimated() {
        let loginScreen = UINavigationController(rootViewController: loginViewController)
        Core.accountManager.logOut()
        animateDismissTransition(to: loginScreen)
    }
}

// MARK: - Transition animations
private extension RootViewController {
    func animateFadeTransition(to new: UIViewController,
                               completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: transitionDuration,
                   options: [.transitionCrossDissolve, .curveEaseOut],
                   animations: { }
        ) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    func animateDismissTransition(to new: UIViewController,
                                  completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: transitionDuration,
                   options: [], animations: {
                    new.view.frame = self.view.bounds }
        ) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
}
