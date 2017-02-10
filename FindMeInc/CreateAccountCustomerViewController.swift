import UIKit

class CreateAccountCustomerViewController: UIViewController {
    @IBOutlet weak var connectWithFacebookButton: UIButton!
    @IBOutlet weak var buttonsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var radioButtonHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Specific constraints for iPhone 5 and SE
        if(UIScreen.main.bounds.size.height == 568){
            buttonsHeightConstraint.constant = buttonsHeightConstraint.constant * 0.8
            connectWithFacebookButton.titleLabel?.font = UIFont(name: "OpenSans", size: 12.0)
        }
        //Specific constraints for iPhone PLUS
        if(UIScreen.main.bounds.size.height == 736){
            buttonsHeightConstraint.constant = buttonsHeightConstraint.constant * 1.2
            radioButtonHeight.constant = radioButtonHeight.constant * 1.4
        }
    }
    
    @IBAction func radioButtonTap(_ sender: CustomRadioButton) {
        sender.isSelected = !sender.isSelected
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
