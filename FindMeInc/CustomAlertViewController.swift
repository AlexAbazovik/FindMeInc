import UIKit

class CustomAlertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell: CustomAlertTableViewCell
            cell = tableView.dequeueReusableCell(withIdentifier: "customAlertTableViewCell", for: indexPath) as! CustomAlertTableViewCell
            switch indexPath.row{
            case 0:
                cell.logo.image = #imageLiteral(resourceName: "FMI_All_Parlor_Icon")
                cell.label.text = "A R T I S T S"
            case 1:
                cell.logo.image = #imageLiteral(resourceName: "FMI_All_Flower_Icon")
                cell.label.text = "T A T T O O S"
            case 2:
                cell.logo.image = #imageLiteral(resourceName: "FMI_All_Ivent_Icon")
                cell.label.text = "E V E N T S"
            case 3:
                cell.logo.image = #imageLiteral(resourceName: "FMI_All_All_Icon")
                cell.label.text = "A L L"
                cell.radioButton.isSelected = true
            default:
                let cellWithButton: CustomAlertTableViewCellWithButton
                cellWithButton = tableView.dequeueReusableCell(withIdentifier: "customAlertTableViewCellWithButton", for: indexPath) as! CustomAlertTableViewCellWithButton
            }
            return cell
    }

    @IBAction func showButtonTap(_ sender: Any) {
        view.superview?.isHidden = true
    }
}
