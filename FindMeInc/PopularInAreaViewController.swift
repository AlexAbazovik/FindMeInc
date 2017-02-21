import UIKit
import Kingfisher

class PopularInAreaViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var alertView: UIView!

    var tempURL:String!
    var tempImage: UIImage!
    var dataPassed = [String]()
    
    let refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        sendRequestToRetrieveListPhoto()
        
        refresher.addTarget(self, action: #selector(sendRequestToRetrieveListPhoto), for: .valueChanged)
        collectionView.addSubview(refresher)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Data.sharedInfo.urlCollectionForNewsFeed != nil{
            return (Data.sharedInfo.urlCollectionForNewsFeed?.count)! + 1
        }else{
            return 0
        }
    }
    
    //MARK: Send request to list of images
    func sendRequestToRetrieveListPhoto(){
        MySession.sharedInfo.getImagesList(parameters: dataPassed, onSucsess: { (response) in
            Data.sharedInfo.urlCollectionForNewsFeed = (response.value(forKey: "data") as! NSDictionary)
            self.collectionView.reloadData()
            self.refresher.endRefreshing()
        }) { (error) in
            print(error)
        }
    }
    
    //MARK: Add images to newsfeed
    /*
        For different types of images used different stamp-images. It depends on who posted this image. Types of stamps:
        0 - event stamp
        1 - user stamp
        2 - parlor stamp
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == (Data.sharedInfo.urlCollectionForNewsFeed?.count)!{
            let lastCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastCollectionViewCell", for: indexPath)
            return lastCell
        }else{
            var cell: PopularInYourAreaCollectionViewCell
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! PopularInYourAreaCollectionViewCell
            cell.mainImage.image = nil
            let url = URL.init(string: Data.sharedInfo.urlCollectionForNewsFeed?.allKeys[indexPath.row] as! String)
            cell.mainImage.kf.setImage(with: url)
            switch (Data.sharedInfo.urlCollectionForNewsFeed?.allValues[indexPath.row] as! NSDictionary).value(forKey: "code") as! Int{
            case 0:
                cell.stamp.image = #imageLiteral(resourceName: "FMI_All_Ivent_Icon")
            case 1:
                cell.stamp.image = #imageLiteral(resourceName: "FMI_All_Flower_Icon")
            case 2:
                cell.stamp.image = #imageLiteral(resourceName: "FMI_All_Parlor_Icon")
            default: break
            }
            return cell
        }
    }
    
     func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        var size = CGSize(width: 165, height: 240)
        if indexPath.row != (Data.sharedInfo.urlCollectionForNewsFeed?.count)!{
            if (Data.sharedInfo.urlCollectionForNewsFeed?.allValues[indexPath.row] as! NSDictionary).value(forKey: "code") as! Int == 0{
                size = CGSize(width: collectionView.frame.width, height: 200.0)
            }
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TO DO: Add code for return data to server
        // and transition to next view:
        // for event to event detail view
        // for user and artist to profile screen
    }
    
    @IBAction func optionsButtonTap(_ sender: UIBarButtonItem){
        alertView.isHidden = false
    }
    
    //MARK: Reload data in collection view with filter
    @IBAction func filteringOptionsDidSelect(_ sender: UIStoryboardSegue?){
        sendRequestToRetrieveListPhoto()
    }
    
    //MARK: Show more buton
    //If the user reached the bottom of collection view he can load more photos in newsfeed
    @IBAction func loadMorePhotoInNewsfeed(_ sender: UIButton){
        dataPassed += ["more"]
        sendRequestToRetrieveListPhoto()
    }
}
