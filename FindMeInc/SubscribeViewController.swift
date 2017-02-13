import UIKit

class SubscribeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var subscribeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subscribeTableView.dataSource = self
        subscribeTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subscribeTableView.dequeueReusableCell(withIdentifier: "subscribeCell", for: indexPath) as! SubscribeTableViewCell
        if indexPath.row == 1{
            cell.name.text = "Q U A R T E R L Y  P L A N"
            cell.costWithoutDiscount.image = #imageLiteral(resourceName: "FMI_Subscribe_150")
            cell.costWithDiscount.image = #imageLiteral(resourceName: "FMI_Subscribe_With_Discount_95")
        }
        if indexPath.row == 2{
            cell.name.text = "6 M O N T H  P L A N"
            cell.costWithoutDiscount.image = #imageLiteral(resourceName: "FMI_Subscribe_300")
            cell.costWithDiscount.image = #imageLiteral(resourceName: "FMI_Subscribe_With_Discount_180")
        }
        return cell
    }
}
