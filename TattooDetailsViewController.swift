//MARK: - TODO Привязать к user page


import UIKit

class TattooDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: Outlets
    @IBOutlet weak var userName: UINavigationItem!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likeButoon: UIButton!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var chatCount: UILabel!
    @IBOutlet weak var photoDescription: UILabel!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var savedLabel: UILabel!
    
    var userID: Int?
    
    //This variable used for transfer data from alert view controller
    var indexPathItemInNewsFeed : Int?
    
    var tagsCollection: [String]?
    var photoTransitionsOptions = UIViewAnimationOptions.showHideTransitionViews
    
    //MARK: Var for sent to Chat view controller
    var photoID: Int?
    
    //MARK: View life cilce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Load data on the view from the server
    func loadData(){
        self.photoID = (Data.sharedInfo.dataCollectionForNewsFeed![indexPathItemInNewsFeed!] as! NSDictionary).value(forKey: "id") as? Int
        
        MySession.sharedInfo.getTattooDetails(photoID: photoID!, onSuccess: { (photoDescription) in
            self.userID = photoDescription.value(forKey: "user_id") as! Int?
            self.userName.title = photoDescription.value(forKey: "username") as! String?
            let url = URL.init(string: (Data.sharedInfo.dataCollectionForNewsFeed?[self.indexPathItemInNewsFeed!] as! NSDictionary).value(forKey: "url") as! String)
            UIView.transition(with: self.photo, duration: 0.5, options: self.photoTransitionsOptions, animations: {
                self.photo.kf.setImage(with: url)
            }, completion: nil)
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
        if sender.isSelected {
            likesCount.text = String(Int(likesCount.text!)! - 1)
            MySession.sharedInfo.photoLike(photoID: photoID!, userID: UserDefaults.standard.value(forKey: "userID") as! Int, like: false)
        } else {
            likesCount.text = String(Int(likesCount.text!)! + 1)
                        MySession.sharedInfo.photoLike(photoID: photoID!, userID: UserDefaults.standard.value(forKey: "userID") as! Int, like: true)
        }
        sender.isSelected = !sender.isSelected
    }
    
    func actionLike(_ sender: UIButton) -> Void {
        if sender.isSelected {
            likesCount.text = String(Int(likesCount.text!)! - 1)
            MySession.sharedInfo.photoLike(photoID: photoID!, userID: UserDefaults.standard.value(forKey: "userID") as! Int, like: false)
        } else {
            likesCount.text = String(Int(likesCount.text!)! + 1)
            MySession.sharedInfo.photoLike(photoID: photoID!, userID: UserDefaults.standard.value(forKey: "userID") as! Int, like: true)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func actionDoubleTap(_ sender: Any) {
        actionLike(likeButoon)
    }
    
    //MARK: Tags collection view data source
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
        (cell.viewWithTag(1) as! UILabel).adjustsFontSizeToFitWidth = true
        return cell
    }
    
    //MARK: Transition to other image by swipe
    @IBAction func previousPhotoPresent(_ sender: Any) {
        if indexPathItemInNewsFeed != 0{
            indexPathItemInNewsFeed = indexPathItemInNewsFeed! - 1
            photoTransitionsOptions = [UIViewAnimationOptions.transitionFlipFromLeft]
            loadData()
        }
    }
    
    @IBAction func nextPhotoPresent(_ sender: Any) {
        if indexPathItemInNewsFeed! != (Data.sharedInfo.dataCollectionForNewsFeed?.count)! - 10 {
            indexPathItemInNewsFeed = indexPathItemInNewsFeed! + 1
                        photoTransitionsOptions = [UIViewAnimationOptions.transitionFlipFromRight]
            loadData()
        } else {
            MySession.sharedInfo.getImagesList(parameters: nil, more: true, onSucsess: { (success) in
            }, onFailure: { (error) in
                print(error)
            })
            self.indexPathItemInNewsFeed = self.indexPathItemInNewsFeed! + 1
        }
    }
    
    //MARK: Share image function
    @IBAction func sharePhoto(){
        let activityViewController = UIActivityViewController(activityItems: [photo.image!], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: Save image in library
    //TO DO: Save photo to user page collection
    @IBAction func savePhotoToLibrary() {
        UIImageWriteToSavedPhotosAlbum(photo.image!, photoSaved(), nil, nil)
    }
    
    //MARK: Show message when photo saved
    func photoSaved() {
        savedLabel.alpha = 1.0
        UIView.animate(withDuration: 1.0, delay: 0.0, animations: {
            self.savedLabel.alpha = 0.0
        }, completion: nil)
    }
    
    //MARK: Prepare for transition
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromTattoDetailsToComments" {
        let recipeViewContorller = segue.destination as! CommentsViewController
            recipeViewContorller.photoID = photoID
        } else if segue.identifier == "segueFromTattooDetailToUserPage" {
            let userPageViewController = segue.destination as! UserPageViewController
            userPageViewController.userIDFromSegue = userID
        }
}
}
