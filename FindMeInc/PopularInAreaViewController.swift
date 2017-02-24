import UIKit
import Kingfisher

class PopularInAreaViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var mainActivityIndicator: UIActivityIndicatorView!
    
    //This variable used for transfer data from alert view controller
    var dataPassed = [String]()
    
    let refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UIScreen.main.bounds.size.height == 568){
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "OpenSans-Semibold", size: 15)!, NSForegroundColorAttributeName: #colorLiteral(red: 0.2588235294, green: 0.2549019608, blue: 0.2588235294, alpha: 1)]
        }
        
        //MARK: Add refresher on the collection view
        refresher.addTarget(self, action: #selector(sendRequestToRetrieveListPhoto), for: .valueChanged)
        collectionView.addSubview(refresher)
        
        //MARK: Start main activity indicator
        // Do it if request to server very long
        mainActivityIndicator.startAnimating()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        sendRequestToRetrieveListPhoto()
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
            Data.sharedInfo.urlCollectionForNewsFeed = response
            self.collectionView.reloadData()
            self.refresher.endRefreshing()
            self.mainActivityIndicator.stopAnimating()
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
        
        //If cell the last cell in this collection show cell with ActivityIndicator
        
        if indexPath.row == (Data.sharedInfo.urlCollectionForNewsFeed?.count)!{
            let lastCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastCollectionViewCell", for: indexPath)
            
            //MARK: Start animate activity indicator
            (lastCell.viewWithTag(1) as! UIActivityIndicatorView).startAnimating()
            return lastCell
        }else{
            var cell: PopularInYourAreaCollectionViewCell
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! PopularInYourAreaCollectionViewCell
            cell.mainImage.image = nil
            let url = URL.init(string: (Data.sharedInfo.urlCollectionForNewsFeed![indexPath.row] as! NSDictionary).value(forKey: "url") as! String)
            
            //MARK: Download photo
            cell.mainImage.kf.setImage(with: url)
            
            //MARK: Add different stamp on iamge depending on type of content
            switch (Data.sharedInfo.urlCollectionForNewsFeed?[indexPath.row] as! NSDictionary).value(forKey: "code") as! Int{
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
    
    //MARK: Configure cell size
     func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        var size = CGSize(width: 165, height: 240)
        
        //MARK: Specific cell size for iPhone 5 and SE
        if(UIScreen.main.bounds.size.height == 568){
            size = CGSize(width: 135, height: 200)
        }
        //MARK: Specific cell size for iPhone PLUS
        if(UIScreen.main.bounds.size.height == 736){
            size = CGSize(width: 180, height: 270)
        }

        if indexPath.row != (Data.sharedInfo.urlCollectionForNewsFeed?.count)!{
            
            // Specific cell size for one with event contemt type
            if (Data.sharedInfo.urlCollectionForNewsFeed?[indexPath.row] as! NSDictionary).value(forKey: "code") as! Int == 0{
                size = CGSize(width: collectionView.frame.width, height: 200.0)
                if(UIScreen.main.bounds.size.height == 736){
                    size = CGSize(width: collectionView.frame.width, height: 240)
                }
            }
        }else {
            //MARK: Specific cell size for the last one
            size = CGSize(width: collectionView.frame.width, height: 200.0)
            if(UIScreen.main.bounds.size.height == 736){
                size = CGSize(width: collectionView.frame.width, height: 240)
            }
        }
        return size
    }
    
    @IBAction func optionsButtonTap(_ sender: UIBarButtonItem){
        alertView.isHidden = false
    }
    
    //MARK: Reload data in collection view with filter
    @IBAction func filteringOptionsDidSelect(_ sender: UIStoryboardSegue?){
        sendRequestToRetrieveListPhoto()
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
    }
    
    //MARK: Show more buton
    //If the user reached the bottom of collection view he can load more photos in newsfeed
    //At the moment, function not works by push the button, but when collection view swipe almoust antil the end.
    @IBAction func loadMorePhotoInNewsfeed(_ sender: UIButton?){
        dataPassed.append("more")
        sendRequestToRetrieveListPhoto()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (Data.sharedInfo.urlCollectionForNewsFeed?.count)! - 10{
            loadMorePhotoInNewsfeed(nil)
        }
    }
    
    //MARK: Send data to Tatto details view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToTattoDetail"{
        let recipeViewController = segue.destination as! TattooDetailsViewController
        recipeViewController.dataPassed = (self.collectionView.indexPathsForSelectedItems?[0].row)!
        }
    }
}
