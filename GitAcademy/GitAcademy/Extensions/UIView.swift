import UIKit

extension UIView {

    static private let shadowColor = UIColor.darkGray.cgColor

    func roundCorners(radius: CGFloat? = nil, clips: Bool? = nil) {
        if let radius = radius {
            layer.cornerRadius = radius
        } else {
            layer.cornerRadius = frame.height/2
        }
        
        if let clips = clips {
            clipsToBounds = clips
        }
    }
    
    func setShadow(offsetSize: CGSize = CGSize(width: 5, height: 5), color: CGColor = shadowColor, opacity: Float = 0.4, radius: CGFloat = 5) {
        layer.shadowOffset = offsetSize
        layer.shadowColor = color
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
