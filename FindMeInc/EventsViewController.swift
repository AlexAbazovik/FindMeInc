import UIKit

class EventsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets

    @IBOutlet weak var conventionsCollectionView: UICollectionView!
    @IBOutlet weak var localEventsCollectionView: UICollectionView!
    
    @IBOutlet var filteringButtonsCollection: [UIButton]!
    
    @IBOutlet weak var calendarTableView: UITableView!
    
    @IBOutlet weak var calendarView: UIView!
    
    var calendarInfo: NSArray?
    
    //MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       calendarInfo = [
        [
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
        ],
        [
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
            ]
        ],
        [
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
            ]
            
        ],
        [
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
                
            ]
        ],
        [
            "FEB28": [
                
            ]
        ],
        [
            "FEB29": [
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
        return calendarInfo!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (calendarInfo?[section] as! NSDictionary).allKeys[0] as? String
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = (calendarInfo![section] as! NSDictionary).allKeys[0] as! NSString
        return ((calendarInfo![section] as! NSDictionary).object(forKey: key) as! NSArray).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = calendarInfo![indexPath.section] as! NSDictionary
        let key = data.allKeys[0] as! NSString
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell") as! CalendarTableViewCell
        
        if ((data.object(forKey: key) as! NSArray).count != 0) {
            cell.frame = CGRect(x: 0.0, y: 0.0, width: self.calendarTableView.frame.width, height: 50.0)
            
            let info = (data.object(forKey: key) as! NSArray)[indexPath.row] as! NSDictionary
            
            cell.name.text = info.object(forKey: "name") as! String?
            cell.money.text = info.object(forKey: "money") as! String?
            cell.time.text = info.object(forKey: "time") as! String?
            cell.tattooDescription.text = info.object(forKey: "tattooDescription") as! String?
        } else {
            cell.frame = CGRect(x: 0.0, y: 0.0, width: self.calendarTableView.frame.width, height: 0.0)
        }
       
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let colorConstant:Float = 255.0
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 35, height: self.calendarTableView.frame.width)
        let key = (calendarInfo![section] as! NSDictionary).allKeys[0] as! NSString
        if (key.isEqual(to: "TODAY")) {
            view.backgroundColor = UIColor.init(colorLiteralRed: 229.0 / colorConstant, green: 157.0 / colorConstant, blue: 97.0 / colorConstant, alpha: 1.0)
            
            view.addSubview(getDateLabelWith(date: key, leftSide: true))
            view.addSubview(getDateLabelWith(date: getCurrentDate(), leftSide: false))
            
        } else if (((calendarInfo![section] as! NSDictionary).object(forKey: key) as! NSArray).count == 0) {
            view.backgroundColor = UIColor.black;
            
            view.addSubview(getDateLabelWith(date: key, leftSide: true))
            view.addSubview(getPlusButton())
        } else {
            view.backgroundColor = UIColor.init(colorLiteralRed: 147.0 / colorConstant, green: 149.0 / colorConstant, blue: 152.0 / colorConstant, alpha: 1.0)
            
            view.addSubview(getDateLabelWith(date: key, leftSide: true))
            view.addSubview(getPlusButton())
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Current date
    
    func getCurrentDate() -> NSString {
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return "\(formatter.string(from: date as Date))" as NSString
    }
    
    //MARK: - UILabel
    
    func getDateLabelWith(date: NSString, leftSide argument:Bool) -> UILabel {
        let colorConstant:Float = 241.0 / 255.0
        
        let label = UILabel()
        
        label.text = date as String
        label.textColor = UIColor.init(colorLiteralRed: colorConstant, green: colorConstant, blue: colorConstant, alpha: 1.0)
        label.font = UIFont.init(name: "Open Sans", size: 17.0)
        
        label.sizeToFit()
        if (argument) {
            label.center = CGPoint(x: label.frame.width / 2.0 + 5.0, y: 15)
        } else {
            label.center = CGPoint(x: self.calendarTableView.frame.width - label.frame.width / 2.0 - 5.0, y: 15)
        }
        
        return label
    }
    
    //MARK: - UIButton
    
    func getPlusButton() -> UIButton {
        let colorConstant:Float = 241.0 / 255.0
        
        let button = UIButton.init(frame: CGRect(x: self.calendarTableView.frame.width - 35.0, y: 0.0, width: 30.0, height: 30.0))
        button.setTitle("+", for: UIControlState.normal)
        button.titleLabel?.textColor = UIColor.init(colorLiteralRed: colorConstant, green: colorConstant, blue: colorConstant, alpha: 1.0)
        button.titleLabel?.font = UIFont.init(name: "Open Sans", size: 17.0)
        
        return button
    }
}
