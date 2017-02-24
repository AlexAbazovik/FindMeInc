import UIKit

class TattooDetailsViewController: UIViewController {

    @IBOutlet weak var userName: UINavigationItem!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likeButoon: UIButton!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var chatCount: UILabel!
    @IBOutlet weak var photoDescription: UILabel!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    //This variable used for transfer data from alert view controller
    var dataPassed : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MySession.sharedInfo.getTattooDetails(photoID: (Data.sharedInfo.urlCollectionForNewsFeed![dataPassed!] as! NSDictionary).value(forKey: "id") as! Int, userType: (Data.sharedInfo.urlCollectionForNewsFeed![dataPassed!] as! NSDictionary).value(forKey: "code") as! Int, onSuccess: { (photoDescription) in
            print(self.dataPassed)
            self.userName.title = photoDescription.value(forKey: "username") as! String?
            let url = URL.init(string: (Data.sharedInfo.urlCollectionForNewsFeed?[self.dataPassed!] as! NSDictionary).value(forKey: "url") as! String)
            self.photo.kf.setImage(with: url)
        }) { (error) in
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
