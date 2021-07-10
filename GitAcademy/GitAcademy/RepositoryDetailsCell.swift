import UIKit

class RepositoryDetailsCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet private weak var starsButton: UIButton!
    @IBOutlet private weak var languageIconView: UIView!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var contributorsButton: UIButton!
    
    @IBAction func starsButtonAction(_ sender: UIButton) {
        print("🟢 starsButton did Tap")
    }
    
    @IBAction func contributorsButtonAction(_ sender: UIButton) {
        print("🟢 contributorsButton did Tap")
    }
    
    func fillContent(for repository: Repository) {
        repositoryNameLabel.text = repository.name
        repositoryDescriptionLabel.text = repository.description
    }
}
