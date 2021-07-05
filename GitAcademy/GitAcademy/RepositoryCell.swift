import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    
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
    
    func fillContent() {
        iconImageView.image = UIImage(imageLiteralResourceName: "testAvatar")
        titleLabel.text = "Test Title"
        countLabel.text = "51"
    }
}
