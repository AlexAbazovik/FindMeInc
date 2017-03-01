import UIKit

class EventDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MAARK: Outlets
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var artistAttendingTableView: UITableView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    @IBOutlet var filteringButtonsCollection: [UIButton]!
    
    @IBOutlet weak var upperLayerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var upperLayerView: UIView!
    
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventAddress: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var attendingCount: UILabel!
    @IBOutlet weak var areYouAttending: UISwitch!
    
    var typeOfEvent: Int?
    var eventID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        
        artistAttendingTableView.delegate = self
        artistAttendingTableView.dataSource = self
        
        sendRequest()
    }

    //MARK: Subviews life cycle
    //MARK: Show or hide upper view
    override func viewDidLayoutSubviews() {
        if areYouAttending.isOn {
            upperLayerTopConstraint.constant = 0
        } else {
            upperLayerView.center = CGPoint(x: upperLayerView.center.x, y: UIScreen.main.bounds.size.height * 2)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func filteringButtonTap(_ sender: UIButton){
        for i in filteringButtonsCollection{
            i.isSelected = false
        }
        sender.isSelected = true
        chatTableView.isHidden = true
        if sender.tag == 0{
            chatTableView.isHidden = false
            artistAttendingTableView.isHidden = true
        }else{
            chatTableView.isHidden = true
            artistAttendingTableView.isHidden = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == chatTableView{
            let cell = chatTableView.dequeueReusableCell(withIdentifier: "inboxTableViewCell", for: indexPath) as! InboxTableViewCell
            return cell
        }else{
            let cell = artistAttendingTableView.dequeueReusableCell(withIdentifier: "artistAttendingTableViewCell", for: indexPath) as! ArtistAttendingTableViewCell
            return cell
        }
    }
    
    
    //MARK: Photo collection view delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Data.sharedInfo.iventDescription != nil{
            return (Data.sharedInfo.iventDescription?.value(forKey: "images") as! NSArray).count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionViewCell", for: indexPath)
        let imageURL = URL.init(string: (Data.sharedInfo.iventDescription?.value(forKey: "images") as! NSArray)[indexPath.row] as! String)
        (cell.viewWithTag(1) as! UIImageView).kf.setImage(with: imageURL)
        return cell
    }
    
    //MARK: Send request to the server
    func sendRequest(){
        MySession.sharedInfo.getEventDetail(type: typeOfEvent!, eventID: eventID!, onSuccess: { (response) in
            Data.sharedInfo.iventDescription = response
            self.loadIventDescription()
        }) { (error) in
            print(error)
        }
    }
    
    //MARK: Load event description
    func loadIventDescription(){
        if Data.sharedInfo.iventDescription?.value(forKey: "images") != nil{
            let imageURL = URL.init(string: (Data.sharedInfo.iventDescription?.value(forKey: "images") as! NSArray)[0] as! String)
            mainPhoto.kf.setImage(with: imageURL)
        }
        eventName.text = Data.sharedInfo.iventDescription?.value(forKey: "name") as! String?
        eventTime.text = Data.sharedInfo.iventDescription?.value(forKey: "time") as! String?
        eventAddress.text = Data.sharedInfo.iventDescription?.value(forKey: "address") as! String?
        eventDescription.text = Data.sharedInfo.iventDescription?.value(forKey: "description") as! String?
        attendingCount.text = Data.sharedInfo.iventDescription?.value(forKey: "attendingCount") as! String?
        areYouAttending.isOn = (Data.sharedInfo.iventDescription?.value(forKey: "isAttend") as! Bool?)!
        photosCollectionView.reloadData()
    }
    
    //MARK: attendingSwitchOn
    @IBAction func attendingSwitchOn(_ sender:UISwitch) {
        if sender.isOn {
            attendingCount.text = String(Int(attendingCount.text!)! + 1)
            showBottomView()
            MySession.sharedInfo.eventAttending(type: typeOfEvent!, eventID: eventID!, isAttend: true)
        } else {
            attendingCount.text = String(Int(attendingCount.text!)! - 1)
            MySession.sharedInfo.eventAttending(type: typeOfEvent!, eventID: eventID!, isAttend: false)
        }
    }
    
    
    func showBottomView() {
        //MARK: Create alert
        let eventName = Data.sharedInfo.iventDescription?.value(forKey: "name")
        let alert = UIAlertController(title: "You are checked in to \(eventName!)", message: "Tell your friends your going or create tattoo consultation for this Convention to find an artist before you attend!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back to event detail", style: .default, handler: { (action) in
            self.areYouAttending.isOn = false
            self.attendingSwitchOn(self.areYouAttending)
        }))
        alert.addAction(UIAlertAction(title: "Create tattoo consultation", style: .default, handler: { (action) in
            print("Create")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
