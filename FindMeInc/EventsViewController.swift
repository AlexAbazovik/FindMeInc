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
            "27022017": [
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
            "28022017": [
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
            "01032017": [
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
            "02032017": [
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
            "03032017": [
                
            ]
        ],
        [
            "04032017": [
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
            self.navigationItem.title = "C A L E N D A R"
        } else {
            calendarView.isHidden = true
            self.navigationItem.title = "E V E N T S"
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
        
        let info = (data.object(forKey: key) as! NSArray)[indexPath.row] as! NSDictionary
        
        cell.name.text = info.object(forKey: "name") as! String?
        cell.money.text = info.object(forKey: "money") as! String?
        cell.time.text = info.object(forKey: "time") as! String?
        cell.tattooDescription.text = info.object(forKey: "tattooDescription") as! String?
        
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
        
        if (key.isEqual(to: getCurrentDate())) {
            view.backgroundColor = UIColor.init(colorLiteralRed: 229.0 / colorConstant, green: 157.0 / colorConstant, blue: 97.0 / colorConstant, alpha: 1.0)
            
            view.addSubview(getDateLabelWith(dateString: key, leftSide: true))
            view.addSubview(getDateLabelWith(dateString: getCurrentDate() as NSString, leftSide: false))
            
        } else if (((calendarInfo![section] as! NSDictionary).object(forKey: key) as! NSArray).count == 0) {
            view.backgroundColor = UIColor.init(colorLiteralRed: 147.0 / colorConstant, green: 149.0 / colorConstant, blue: 152.0 / colorConstant, alpha: 1.0)
            
            view.addSubview(getDateLabelWith(dateString: key, leftSide: true))
            view.addSubview(getPlusButtonWithSection(section))
        } else {
            view.backgroundColor = UIColor.init(colorLiteralRed:  65.0 / colorConstant, green:  66.0 / colorConstant, blue:  67.0 / colorConstant, alpha: 1.0)
            
            view.addSubview(getDateLabelWith(dateString: key, leftSide: true))
            view.addSubview(getPlusButtonWithSection(section))
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Current date
    func getCurrentDate() -> String {
        let date = NSDate()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        
        return "\(dateFormatter.string(from: date as Date))"
    }
    
    //MARK: - UILabel
    func getDateLabelWith(dateString: NSString, leftSide argument:Bool) -> UILabel {
        let colorConstant:Float = 255.0
        
        let label = UILabel()
        
        if (dateString.isEqual(to: getCurrentDate()) && argument) {
            label.text = "TODAY"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy"
            let date = dateFormatter.date(from: dateString as String)
            dateFormatter.dateFormat = "MMMdd"
            label.text = dateFormatter.string(from: date!).uppercased()
        }
        
        if (argument) {
            label.font = UIFont.init(name: "OpenSans-Semibold", size: 17.0)
            label.sizeToFit()
            
            label.center = CGPoint(x: label.frame.width / 2.0 + 5.0, y: 15)
            label.textColor = UIColor.init(colorLiteralRed: 241.0 / colorConstant, green: 241.0 / colorConstant, blue: 241.0 / colorConstant, alpha: 1.0)
        } else {
            label.font = UIFont.init(name: "OpenSans-Regular", size: 17.0)
            label.sizeToFit()
            
            label.center = CGPoint(x: self.calendarTableView.frame.width - label.frame.width / 2.0 - 5.0, y: 15)
            label.textColor = UIColor.init(colorLiteralRed:  65.0 / colorConstant, green:  66.0 / colorConstant, blue:  67.0 / colorConstant, alpha: 1.0)
        }
        
        return label
    }
    
    //MARK: - UIButton
    func getPlusButtonWithSection(_ section: Int) -> UIButton {
        let colorConstant:Float = 241.0 / 255.0
    
        let button = UIButton.init(type: .system)
        button.frame = CGRect(x: self.calendarTableView.frame.width - 35.0, y: 0.0, width: 30.0, height: 30.0)
        button.setTitle("+", for: .normal)
        button.tintColor = UIColor.init(colorLiteralRed: colorConstant, green: colorConstant, blue: colorConstant, alpha: 1.0)
        button.titleLabel?.font = UIFont.init(name: "Open Sans", size: 30.0)
        button.addTarget(self, action: #selector(actionPlus), for: .touchUpInside)
        button.tag = section
        
        return button
    }
    
    //MARK: - Actions
    func actionPlus(_ sender: UIButton) -> Void {
        self.performSegue(withIdentifier: "plusButtonAction", sender: sender)
        print("+", sender.tag)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "plusButtonAction" {
            let dateString = (calendarInfo?[(sender as! UIButton).tag] as! NSDictionary).allKeys[0]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "ddMMyyyy"
            let date = dateFormatter.date(from: dateString as! String)
            print((sender as! UIButton).tag)
            print("plusButtonAction")
            (segue.destination as! AddConsultationViewController).currentDate = date
        }
    }
}
