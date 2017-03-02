import UIKit

class BookingConsultationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Outlets
    @IBOutlet weak var interestedUserTableView: UITableView!
    @IBOutlet weak var artistAttendingTableView: UITableView!
    @IBOutlet var filteringButtonsCollection: [UIButton]!

    @IBOutlet weak var arrowButton: UIButton!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interestedUserTableView.delegate = self
        interestedUserTableView.dataSource = self
        
        artistAttendingTableView.delegate = self
        artistAttendingTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //MARK: Change between interested user and artist attending table view
    @IBAction func filteringButtonTap(_ sender: UIButton){
        for i in filteringButtonsCollection{
            i.isSelected = false
        }
        sender.isSelected = true
        interestedUserTableView.isHidden = true
        if sender.tag == 0{
            interestedUserTableView.isHidden = false
            artistAttendingTableView.isHidden = true
        }else{
            interestedUserTableView.isHidden = true
            artistAttendingTableView.isHidden = false
        }
    }
    
    //MARK: Table view data sourse
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == interestedUserTableView{
            let cell = interestedUserTableView.dequeueReusableCell(withIdentifier: "inboxTableViewCell", for: indexPath) as! InboxTableViewCell
            return cell
        }else{
            let cell = artistAttendingTableView.dequeueReusableCell(withIdentifier: "artistAttendingTableViewCell", for: indexPath) as! ArtistAttendingTableViewCell
            return cell
        }
    }

}
