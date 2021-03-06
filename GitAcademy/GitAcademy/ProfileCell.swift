import UIKit
// TODO: Create Parent cell for ProfileCell and RepositoryCell and iherit common stuff from there
class ProfileCell: UITableViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var avatarContainerView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var followersButton: UIButton!
    @IBOutlet private weak var followingButton: UIButton!
    @IBOutlet private weak var followButton: UIButton!
    
    private let shadowOffset = CGSize(width: 10, height: 10)
    private let shadowOpacity: Float = 0.4
    private let shadowRadius: CGFloat = 8
    private let cornerRadius: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.roundCorners(radius: cornerRadius)
        containerView.setShadow()
        avatarImageView.roundCorners()
        avatarContainerView.roundCorners()
        avatarContainerView.setShadow(offsetSize: shadowOffset,
                                      opacity: shadowOpacity,
                                      radius: shadowRadius)
    }
    
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
    func fillContent(for user: User) {
        avatarImageView.downloaded(from: user.avatar)
        nameLabel.isHidden = user.name == nil
        nameLabel.text = user.name
        userNameLabel.text = user.username
        followersButton.setTitle("\(user.followers) followers", for: .normal)
        followingButton.setTitle("\(user.following) following", for: .normal)
    }
}
