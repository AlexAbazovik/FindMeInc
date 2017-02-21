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
                cell.radioButton.addTarget(self, action: #selector(radioButtonTap), for: .touchUpInside)
            case 1:
                cell.logo.image = #imageLiteral(resourceName: "FMI_All_Flower_Icon")
                cell.label.text = "T A T T O O S"
                cell.radioButton.addTarget(self, action: #selector(radioButtonTap), for: .touchUpInside)
            case 2:
                cell.logo.image = #imageLiteral(resourceName: "FMI_All_Ivent_Icon")
                cell.label.text = "E V E N T S"
                cell.radioButton.addTarget(self, action: #selector(radioButtonTap), for: .touchUpInside)
            case 3:
                cell.logo.image = #imageLiteral(resourceName: "FMI_All_All_Icon")
                cell.label.text = "A L L"
                cell.radioButton.isSelected = true
                cell.radioButton.tag = 1
                cell.radioButton.addTarget(self, action: #selector(radioButtonTap), for: .touchUpInside)
            default:
                let cellWithButton: CustomAlertTableViewCellWithButton
                cellWithButton = tableView.dequeueReusableCell(withIdentifier: "customAlertTableViewCellWithButton", for: indexPath) as! CustomAlertTableViewCellWithButton
            }
            return cell
    }

    @IBAction func showButtonTap(_ sender: Any) {
        view.superview?.isHidden = true
    }
    
    //MARK: Deselect "All" filter option when one another selected
    func radioButtonTap(_ sender: CustomRadioButton){
        if sender.tag == 1{
            if sender.isSelected{
                for i in tableView.visibleCells{
                    let cell = (i as! CustomAlertTableViewCell)
                    if cell.radioButton.tag != 1{
                        cell.radioButton.isSelected = false
                    }
                }
            }
        }else{
            for i in tableView.visibleCells{
                let cell = (i as! CustomAlertTableViewCell)
                if cell.radioButton.tag == 1{
                    cell.radioButton.isSelected = false
                }
            }
        }
    }
    
    //MARK: Add data to send to the Popular in area view controller
    /*
        If radio button in cell selected i add filter in array and send data to server
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var selectedFilterElements = [String]()
        for i in tableView.visibleCells{
            let cell = (i as! CustomAlertTableViewCell)
            if cell.radioButton != nil{
                if cell.radioButton.isSelected{
                    selectedFilterElements.append((cell.label.text?.lowercased().replacingOccurrences(of: " ", with: ""))!)
                }
            }
        }
        if segue.identifier == "unwindSegueToPopularInAreaView"{
            let recipeViewController = segue.destination as! PopularInAreaViewController
            recipeViewController.dataPassed = selectedFilterElements
        }
    }
}
