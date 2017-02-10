import UIKit

class ArtistAttendingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var salonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
