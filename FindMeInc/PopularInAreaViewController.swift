import UIKit

class PopularInAreaViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var alertView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: PopularInYourAreaCollectionViewCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! PopularInYourAreaCollectionViewCell
        cell.mainImage.image = #imageLiteral(resourceName: "FMI_Temp_Tattoo_Photo")
        if indexPath.row == 2{
            cell.mainImage.image = #imageLiteral(resourceName: "FMI_Temp_Main_Picture")
            cell.stamp.image = #imageLiteral(resourceName: "FMI_All_Ivent_Icon")
        }
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        var size = CGSize(width: 160, height: 260)
        if indexPath.row == 2{
            size = CGSize(width: collectionView.frame.width, height: 160.0)
        }
        return size
    }
    
    @IBAction func optionsButtonTap(_ sender: UIBarButtonItem){
        alertView.isHidden = false
    }
}
