import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = RootViewController()
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

// TODO: Change ForceUnwraping with "!" to something more acceptable
// Force-unwrap is totally reasonable here as long as we don’t change the RootViewController.
// If we do suddenly change it — crashing the app is probably the best way to go anyway.
extension SceneDelegate {
    static var shared: SceneDelegate {
        return UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
    }
    
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
}
