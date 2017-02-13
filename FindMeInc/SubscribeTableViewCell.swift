import UIKit

class SubscribeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var planDescription: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var costWithoutDiscount: UIImageView!
    @IBOutlet weak var costWithDiscount: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
