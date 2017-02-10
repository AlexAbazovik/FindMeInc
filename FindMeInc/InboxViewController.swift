import UIKit

class InboxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var temp = true
    
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: InboxTableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "inboxTableViewCell", for: indexPath) as! InboxTableViewCell
        cell.profilePicture.backgroundColor = UIColor.black
        if temp{
            cell.detailButton.setImage(#imageLiteral(resourceName: "FMI_Inbox_New_Message_Icon"), for: .normal)
            cell.detailButtonWidthConstraint.constant = 15
            temp = false
        }
        
        return cell
    }
}
