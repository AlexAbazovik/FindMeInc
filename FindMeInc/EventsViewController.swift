import UIKit

class EventsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var conventionsCollectionView: UICollectionView!
    @IBOutlet weak var localEventsCollectionView: UICollectionView!
    
    @IBOutlet var filteringButtonsCollection: [UIButton]!
    
    @IBOutlet weak var calendarTableView: UITableView!
    
    @IBOutlet weak var calendarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conventionsCollectionView.delegate = self
        conventionsCollectionView.dataSource = self
        
        localEventsCollectionView.delegate = self
        localEventsCollectionView.dataSource = self
        
        calendarTableView.delegate = self
        calendarTableView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = conventionsCollectionView.dequeueReusableCell(withReuseIdentifier: "eventsCollectionViewCell", for: indexPath) as! EventCollectionViewCell
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func filteringChange(_ sender: UIButton){
        for i in filteringButtonsCollection{
            i.isSelected = false
        }
        sender.isSelected = true
        if sender.tag == 1{
            calendarView.isHidden = false
        }else{
            calendarView.isHidden = true
        }
    }
    
    //MARK: Calendar
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = calendarTableView.dequeueReusableCell(withIdentifier: "todayCell")
        switch indexPath.row{
        case 1:
            cell = calendarTableView.dequeueReusableCell(withIdentifier: "infoCell")
        case 2:
            cell = calendarTableView.dequeueReusableCell(withIdentifier: "infoCell")
        case 3:
            cell = calendarTableView.dequeueReusableCell(withIdentifier: "dayCell")
            cell?.contentView.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2549019608, blue: 0.2588235294, alpha: 1)
        case 4:
            cell = calendarTableView.dequeueReusableCell(withIdentifier: "infoCell")
        case 5:
            cell = calendarTableView.dequeueReusableCell(withIdentifier: "dayCell")
        default:
            break
        }
        return cell!
    }
}
