import UIKit

class RepositoryCell: UITableViewCell {
    @IBOutlet private weak var iconContainerView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconContainerView.roundCorners(radius: 10)
    }
    
    func fillRepositories() {
        iconContainerView.backgroundColor = .systemPurple
        iconImageView.image = #imageLiteral(resourceName: "repositories")
        titleLabel.text = "Repositories"
        countLabel.text = String(Core.profile.repositories.count)
    }
    
    func fillStarred() {
        iconContainerView.backgroundColor = .systemYellow
        iconImageView.image = #imageLiteral(resourceName: "starred")
        titleLabel.text = "Starred"
        countLabel.text = String(Core.profile.starredRepositories.count)
    }
}
