import UIKit

class RepositoryCell: UITableViewCell {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    
    func fillRepositories() {
        iconImageView.image = UIImage(imageLiteralResourceName: "testAvatar")
        titleLabel.text = "Repositories"
        countLabel.text = String(Core.profile.repositories.count)
    }
    
    func fillStarred() {
        iconImageView.image = UIImage(imageLiteralResourceName: "testAvatar")
        titleLabel.text = "Starred"
        countLabel.text = String(Core.profile.starredRepositories.count)
    }
}
