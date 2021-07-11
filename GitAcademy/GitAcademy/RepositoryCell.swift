import UIKit

// TODO: Create Parent cell for ProfileCell and RepositoryCell and iherit common stuff from there
class RepositoryCell: MainTableViewCellOld {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var iconContainerView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    
//    private let cornerRadius: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconContainerView.roundCorners(radius: cornerRadius)
        containerView.roundCorners(radius: cornerRadius)
        containerView.setShadow()
    }
    
    func fillRepositories(with count: Int) {
        iconContainerView.backgroundColor = .systemPurple
        iconImageView.image = #imageLiteral(resourceName: "repositories")
        titleLabel.text = "Repositories"
        countLabel.text = String(count)
    }
    
    func fillStarred(with count: Int) {
        iconContainerView.backgroundColor = .systemYellow
        iconImageView.image = #imageLiteral(resourceName: "starred")
        titleLabel.text = "Starred"
        countLabel.text = String(count)
    }
}
