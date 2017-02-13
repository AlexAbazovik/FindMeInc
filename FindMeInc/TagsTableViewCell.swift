import UIKit

class TagsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var radioButton: CustomRadioButton!
    @IBOutlet weak var tagLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    @IBAction func radioButtonTap(_ sender: CustomRadioButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            if !MySession.sharedInfo.tagsCollection.contains(tagLabel.text!){
                MySession.sharedInfo.tagsCollection.append(tagLabel.text!)
            }
        }else{
            MySession.sharedInfo.tagsCollection.remove(at: MySession.sharedInfo.tagsCollection.index(of: tagLabel.text!)!)
        }
        let tableView = super.superview?.superview as! UITableView
        tableView.reloadData()
    }

}
