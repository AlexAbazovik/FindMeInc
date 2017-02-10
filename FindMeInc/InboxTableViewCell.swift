import UIKit

class InboxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    @IBOutlet weak var detailButtonWidthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        profilePicture.layer.cornerRadius = 35
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
