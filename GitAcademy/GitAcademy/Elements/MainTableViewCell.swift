import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        self.backgroundColor = Colors.cellBackground
    }
}
