import UIKit

class CustomAlertTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var radioButton: CustomRadioButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func radioButtonTap(_ sender: CustomRadioButton){
        sender.isSelected = !sender.isSelected
    }
    
}
