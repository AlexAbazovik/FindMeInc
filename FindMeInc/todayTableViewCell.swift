import UIKit

class todayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        let date = NSDate()

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        dateLabel.text = "\(formatter.string(from: date as Date))"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
