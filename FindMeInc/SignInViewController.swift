import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var heightButtonsConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Specific constraints for iPhone 5 and SE
        if(UIScreen.main.bounds.size.height == 568){
            heightButtonsConstraints.constant = heightButtonsConstraints.constant * 0.8
        }
        //Specific constraints for iPhone PLUS
        if(UIScreen.main.bounds.size.height == 736){
            heightButtonsConstraints.constant = heightButtonsConstraints.constant * 1.2
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
