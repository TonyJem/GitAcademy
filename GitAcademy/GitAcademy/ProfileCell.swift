import UIKit

class ProfileCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var followersButton: UIButton!
    @IBOutlet private weak var followingButton: UIButton!
    @IBOutlet private weak var followButton: UIButton!
    
//    MARK: - Actions
    @IBAction func followersButonAction(_ sender: UIButton) {
        print("🟢 Followers Button Did Tap")
    }
    
    @IBAction func followingButtonAction(_ sender: UIButton) {
        print("🟢 Following Button Did Tap")
    }
    
    @IBAction func followButtonAction(_ sender: UIButton) {
        print("🟢 Follow Button Did Tap")
    }

//    MARK: - Methods
    func fillContent() {
        // TODO: Find better sollution how to inject User data without using Core
        let user = Core.profile.user
        avatarImageView.roundCorners()
        avatarImageView.downloaded(from: user.avatar_url)
        nameLabel.isHidden = user.name == nil
        nameLabel.text = user.name
        loginLabel.text = user.login
        followersButton.setTitle("\(user.followers) followers", for: .normal)
        followingButton.setTitle("\(user.following) following", for: .normal)
    }
}
