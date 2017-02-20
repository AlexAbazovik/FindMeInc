import UIKit

class todayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        let date = NSDate()
        let calendar = NSCalendar.current
        let formatter = DateFormatter()
        
        dateLabel.text = "\(calendar.component(.month, from: date as Date))"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
