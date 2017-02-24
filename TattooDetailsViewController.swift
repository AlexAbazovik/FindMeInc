import UIKit

class TattooDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var userName: UINavigationItem!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likeButoon: UIButton!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var chatCount: UILabel!
    @IBOutlet weak var photoDescription: UILabel!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    //This variable used for transfer data from alert view controller
    var dataPassed : Int?
    
    var tagsCollection: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        MySession.sharedInfo.getTattooDetails(photoID: (Data.sharedInfo.urlCollectionForNewsFeed![dataPassed!] as! NSDictionary).value(forKey: "id") as! Int, userType: (Data.sharedInfo.urlCollectionForNewsFeed![dataPassed!] as! NSDictionary).value(forKey: "code") as! Int, onSuccess: { (photoDescription) in
            print(photoDescription)
            self.userName.title = photoDescription.value(forKey: "username") as! String?
            let url = URL.init(string: (Data.sharedInfo.urlCollectionForNewsFeed?[self.dataPassed!] as! NSDictionary).value(forKey: "url") as! String)
            self.photo.kf.setImage(with: url)
            self.likeButoon.isSelected = photoDescription.value(forKey: "is_like") as! Bool
            self.likesCount.text = photoDescription.value(forKey: "likes") as? String
            self.chatCount.text = photoDescription.value(forKey: "comments") as? String
            self.photoDescription.text = photoDescription.value(forKey: "title") as? String
            self.tagsCollection = photoDescription.value(forKey: "tags") as? [String]
            self.tagsCollectionView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    //MARK: Like button tap
    //TO DO: Send button state on the server
    @IBAction func like(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tagsCollection != nil{
            return tagsCollection!.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath)
        (cell.viewWithTag(1) as! UILabel).text = tagsCollection?[indexPath.row]
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
