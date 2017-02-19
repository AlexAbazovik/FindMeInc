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
    
    @IBAction func selectOfUserType(_ sender: UIButton){
        UserDefaults.standard.set(sender.tag, forKey: "userType")
        /*
        switch sender.tag {
        case 1:
            UserDefaults.standard.set("user", forKey: "userType")
        case 2:
            UserDefaults.standard.set("artist", forKey: "userType")
        case 3:
            UserDefaults.standard.set("parlor", forKey: "userType")
        default:
            break
        }*/
    }
}
