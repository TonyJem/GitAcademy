import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    
    let cornerRadius: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.roundCorners(radius: cornerRadius)
        containerView.setShadow()
    }
}
