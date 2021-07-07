import UIKit

class RepositoryDetailsCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var repositoryName: UILabel!
    @IBOutlet private weak var repositoryDescription: UILabel!
    @IBOutlet private weak var starsButton: UIButton!
    @IBOutlet private weak var languageIconView: UIView!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var contributorsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func starsButtonAction(_ sender: UIButton) {
        print("🟢 starsButton did Tap")
    }
    
    @IBAction func contributorsButtonAction(_ sender: UIButton) {
        print("🟢 contributorsButton did Tap")
    }
}
