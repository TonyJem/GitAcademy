import UIKit

class ProfileCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var followersCountLabel: UILabel!
    @IBOutlet private weak var followingCountLabel: UILabel!
    @IBOutlet private weak var followButton: UIButton!
    
    // TODO: Remove method if not used
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // TODO: Remove method if not used
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func followButtonAction(_ sender: UIButton) {
        print("🟢 followButton Did Tap")
    }
    
    func fillContent() {
        // TODO: Find better sollution how to inject User data without using Core
        let user = Core.profile.user
        avatarImageView.image = UIImage(imageLiteralResourceName: "testAvatar")
        nameLabel.text = user.name
        usernameLabel.text = user.login
        followersCountLabel.text = String(user.followers)
        followingCountLabel.text = String(user.following)
    }
}
