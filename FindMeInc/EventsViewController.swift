import UIKit

class EventsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets

    @IBOutlet weak var conventionsCollectionView: UICollectionView!
    @IBOutlet weak var localEventsCollectionView: UICollectionView!
    
    @IBOutlet var filteringButtonsCollection: [UIButton]!
    
    @IBOutlet weak var calendarTableView: UITableView!
    
    @IBOutlet weak var calendarView: UIView!
    
    var calendarInfo: NSDictionary!
    
    //MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       calendarInfo = [
            "TODAY": [
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ],
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ]
            ],
            "FEB25": [
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ],
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ]
            ],
            "FEB26": [
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ],
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ]
            ],
            "FEB27": [
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ],
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ],
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ],
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ],
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ],
                [
                    "name": "Steve Jobs",
                    "money": "1000$ - 1250$",
                    "time": "10:00 - 16:00",
                    "tattooDescription": "Spyder(black and gray)"
                ]
            ]
        ]
        
        print(calendarInfo!)
        
        conventionsCollectionView.delegate = self
        conventionsCollectionView.dataSource = self
        
        localEventsCollectionView.delegate = self
        localEventsCollectionView.dataSource = self
        
        calendarTableView.delegate = self
        calendarTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UICollectionViewDataSource
    
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
    
    @IBAction func filteringChange(_ sender: UIButton){
        for i in filteringButtonsCollection {
            i.isSelected = false
        }
        sender.isSelected = true
        if sender.tag == 1 {
            calendarView.isHidden = false
        } else {
            calendarView.isHidden = true
        }
    }
    
    //MARK: Calendar
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return calendarInfo.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return calendarInfo.allKeys[section] as? String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (calendarInfo.object(forKey: calendarInfo.allKeys[section]) as! NSArray).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = calendarInfo.allKeys[indexPath.section]
        let info = (calendarInfo.object(forKey: key) as! NSArray)[indexPath.row] as! NSDictionary
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell") as! CalendarTableViewCell
        
        cell.name.text = info.object(forKey: "name") as! String?
        cell.money.text = info.object(forKey: "money") as! String?
        cell.time.text = info.object(forKey: "time") as! String?
        cell.tattooDescription.text = info.object(forKey: "tattooDescription") as! String?
       
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print(section)
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 35, height: self.calendarTableView.frame.width)
        view.backgroundColor = UIColor.green
        return view
    }
}
