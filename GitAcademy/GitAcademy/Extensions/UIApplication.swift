import UIKit

extension UIApplication {
    
    private var keyWindow: UIWindow? {
        UIApplication.shared.windows.first { $0.isKeyWindow }
    }
    
    class func topMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topMostViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController,
               top.view.window != nil {
                return topMostViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topMostViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topMostViewController(base: presented)
        }
        
        return base
    }
}
