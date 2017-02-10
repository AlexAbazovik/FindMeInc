import UIKit

class CreateAccountOptionsViewController: UIViewController {

    @IBOutlet weak var buttonsHeightConstraints: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Specific constraints for iPhone 5 and SE
        if(UIScreen.main.bounds.size.height == 568){
            buttonsHeightConstraints.constant = buttonsHeightConstraints.constant * 0.8
        }
        //Specific constraints for iPhone PLUS
        if(UIScreen.main.bounds.size.height == 736){
            buttonsHeightConstraints.constant = buttonsHeightConstraints.constant * 1.2
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
