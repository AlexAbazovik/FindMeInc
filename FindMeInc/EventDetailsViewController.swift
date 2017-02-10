import UIKit

class EventDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var artistAttendingTableView: UITableView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    @IBOutlet var filteringButtonsCollection: [UIButton]!
    
    @IBOutlet weak var upperLayerTopConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        
        artistAttendingTableView.delegate = self
        artistAttendingTableView.dataSource = self
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionViewCell", for: indexPath)
        return cell
    }
    
    @IBAction func showBottomView(_ sender: UIBarButtonItem){
        upperLayerTopConstraint.constant = UIScreen.main.bounds.size.height * 0.65
    }
}
