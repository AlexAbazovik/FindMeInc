import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var heightButtonConstraints: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MySession.sharedInfo.getState(onSuccess: { (result) in
            Data.sharedInfo.states = result
        }) { (error) in
            print(error)
        }
        
        //Specific constraints for iPhone 5 and SE
        if(UIScreen.main.bounds.size.height == 568){
            heightButtonConstraints.constant = heightButtonConstraints.constant * 0.8
        }
        //Specific constraints for iPhone PLUS
        if(UIScreen.main.bounds.size.height == 736){
            heightButtonConstraints.constant = heightButtonConstraints.constant * 1.2
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
