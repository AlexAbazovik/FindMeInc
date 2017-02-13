import UIKit

class ArtistPageUserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var topLayerView: UIView!
    @IBOutlet weak var bottomLayerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topLayerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var hideAdditionalInfoButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var hideAdditionalInfoButton: UIButton!
    
    @IBOutlet weak var profilePictureHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var SQUADButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var staffCollectionView: UICollectionView!
    
    @IBOutlet var filteringButtonsCollection: [UIButton]!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        //Specific constraints for iPhone 5 and SE
        if(UIScreen.main.bounds.size.height == 568){
            profilePictureHeightConstraint.constant *= 0.8
            SQUADButtonHeightConstraint.constant *= 0.8
        }
        //Specific constraints for iPhone PLUS
        if(UIScreen.main.bounds.size.height == 736){
            
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        staffCollectionView.delegate = self
        staffCollectionView.dataSource = self
    }
    
    @IBAction func filteringButtonsTap(_ sender: UIButton) {
        for i in filteringButtonsCollection{
            i.isSelected = false
        }
        sender.isSelected = true
    }
    
    @IBAction func moreInfoButtonTap(_ sender: Any) {

        let transition = CATransition()
        transition.type = kCATransitionPush
        
        UIView.animate(withDuration: 0.6, delay: 1.4, options: UIViewAnimationOptions.showHideTransitionViews, animations: {
                transition.subtype = kCATransitionFromBottom
                self.topLayerView.layer.add(transition, forKey: kCATransition)
                self.topLayerViewTopConstraint.constant += self.bottomLayerViewHeightConstraint.constant
        }, completion: nil)
        
        moreInfoButton.isHidden = true
        hideAdditionalInfoButton.isEnabled = true
        
        hideAdditionalInfoButton.setBackgroundImage(#imageLiteral(resourceName: "FMI_All_HorizontalRow_With_Up_Arrow"), for: .normal)
        hideAdditionalInfoButtonHeightConstraint.constant = 15
    }

    @IBAction func hideAdditionalInfoButtonTap(){
        self.topLayerViewTopConstraint.constant += -self.bottomLayerViewHeightConstraint.constant
        moreInfoButton.isHidden = false
        hideAdditionalInfoButtonHeightConstraint.constant = 1
        hideAdditionalInfoButton.setBackgroundImage(#imageLiteral(resourceName: "FMI_All_Horizontal_Row"), for: .normal)
        hideAdditionalInfoButton.isEnabled = false
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        if collectionView == self.staffCollectionView{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "staffCollectionCell", for: indexPath)
            cell.backgroundColor = UIColor.black
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.white
            }
        }else if collectionView == self.collectionView{
            if indexPath.row == 0 && indexPath.section == 0{
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellWithButton",
                                                              for: indexPath)
            }else{
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "usualCell",
                                                              for: indexPath)
                cell.backgroundColor = UIColor.gray
            }
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
