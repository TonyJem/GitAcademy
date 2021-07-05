import UIKit

class ProfileCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var followersCountLabel: UILabel!
    @IBOutlet private weak var followingCountLabel: UILabel!
    @IBOutlet private weak var followButton: UIButton!
    
    @IBAction func followButtonAction(_ sender: UIButton) {
        print("🟢 followButton Did Tap")
    }
    
    func fillContent() {
        // TODO: Find better sollution how to inject User data without using Core
        let user = Core.profile.user
        avatarImageView.downloaded(from: user.avatar_url)
        nameLabel.isHidden = user.name == nil
        nameLabel.text = user.name
        loginLabel.text = user.login
        followersCountLabel.text = String(user.followers)
        followingCountLabel.text = String(user.following)
    }
}
