import UIKit

class EventDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MAARK: Outlets
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    @IBOutlet weak var upperLayerScrollView: UIScrollView!
    @IBOutlet weak var attendingStack: UIStackView!
    
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventAddress: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var attendingCount: UILabel!
    @IBOutlet weak var areYouAttending: UISwitch!
    
    var typeOfEvent: Int?
    var eventID: Int?
    var plusBarButtonItem = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        
        sendRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        upperLayerScrollViewShow()
    }
    
    //MARK: Subviews life cycle
    //MARK: Show or hide upper view
    override func viewDidLayoutSubviews() {
        
        //TO DO: Add definse of height navigation bar
        if areYouAttending.isOn {
            upperLayerScrollViewShow()
            plusBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "FMI_Inbox_Plus"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(transitionToConsultation))
            plusBarButtonItem.tag = 1
            self.navigationItem.rightBarButtonItem = plusBarButtonItem
        } else {
            upperLayerScrollViewHide()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    //MARK: UpperLayerScrollView hide
    func upperLayerScrollViewHide(){
        upperLayerScrollView.contentOffset = CGPoint(x: 0.0, y: UIScreen.main.bounds.height)
        attendingStack.isHidden = false
    }
    
    //MARK: UpperLayerScrollView show part
    func upperLayerScrollViewPartShow(){
        upperLayerScrollView.contentOffset = CGPoint(x: 0.0, y: -UIScreen.main.bounds.height * 0.8)
        attendingStack.isHidden = false
    }
    
    //MARK: UpperLayerScrollView show
    func upperLayerScrollViewShow(){
        upperLayerScrollView.contentOffset = CGPoint(x: 0.0, y: -65.0)
        attendingStack.isHidden = true
    }
    
    //MARK: Move view by swipe
    @IBAction func swipeUp(_ sender: Any) {
        upperLayerScrollViewShow()
    }
    @IBAction func swipeDown(_ sender: Any) {
        upperLayerScrollViewPartShow()
    }
    
    
    //MARK: attendingSwitchOn
    @IBAction func attendingSwitchOn(_ sender:UISwitch) {
        if sender.isOn {
            attendingCount.text = String(Int(attendingCount.text!)! + 1)
            showAlert()
            MySession.sharedInfo.eventAttending(type: typeOfEvent!, eventID: eventID!, isAttend: true)
        } else {
            attendingCount.text = String(Int(attendingCount.text!)! - 1)
            MySession.sharedInfo.eventAttending(type: typeOfEvent!, eventID: eventID!, isAttend: false)
        }
    }
    
    //MARK: Create alert
    func showAlert() {
        let eventName = Data.sharedInfo.iventDescription?.value(forKey: "name")
        let alert = UIAlertController(title: "You are checked in to \(eventName!)", message: "Tell your friends your going or create tattoo consultation for this Convention to find an artist before you attend!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back to event detail", style: .default, handler: { (action) in
            self.upperLayerScrollViewPartShow()
        }))
        alert.addAction(UIAlertAction(title: "Create tattoo consultation", style: .default, handler: { (action) in
            self.transitionToConsultation()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Transition to consultation
    func transitionToConsultation(){
        self.performSegue(withIdentifier: "segueFromEventDetailToConsultation", sender: nil)
    }
}

