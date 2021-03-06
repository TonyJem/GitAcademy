import UIKit

class RepositoryDetailsCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var avatarContainerView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet private weak var starsButton: UIButton!
    @IBOutlet private weak var languageIconView: UIView!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var contributorsButton: UIButton!
    
    private let cornerRadius: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.roundCorners(radius: cornerRadius)
        containerView.setShadow()
        avatarImageView.roundCorners()
        avatarContainerView.roundCorners()
        languageIconView.roundCorners()
    }
    
    @IBAction func starsButtonAction(_ sender: UIButton) {
        print("🟢 starsButton did Tap")
    }
    
    @IBAction func contributorsButtonAction(_ sender: UIButton) {
        print("🟢 contributorsButton did Tap")
    }
    
    func fillContent(for repository: Repository) {
        usernameLabel.text = repository.owner.username
        avatarImageView.downloaded(from: repository.owner.avatarURL)
        repositoryNameLabel.text = repository.name
        
        if let repositoryDescription = repository.description {
            repositoryDescriptionLabel.text = repositoryDescription
        } else {
            repositoryDescriptionLabel.isHidden = true
        }
        
        if Core.accountManager.profile?.starredRepositories.first(where: {$0.id == repository.id}) != nil {
            starsButton.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
        } else {
            starsButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        }
        
        let starsButtonTitle = String(repository.stargazersCount)
        starsButton.setTitle(starsButtonTitle, for: .normal)
        
        if let language = repository.language {
            languageIconView.backgroundColor = Core.colorManager.selectColor(language: language)
            languageLabel.text = language
        } else {
            languageIconView.isHidden = true
            languageLabel.text = nil
        }
    }
}
