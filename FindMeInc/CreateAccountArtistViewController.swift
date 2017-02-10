import UIKit

class CreateAccountArtistViewController: UIViewController {
    
    @IBOutlet weak var radioButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var connectWithFacebookButton: UIButton!
    @IBOutlet weak var buttonsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Specific constraints for iPhone 5 and SE
        if(UIScreen.main.bounds.size.height == 568){
            buttonsHeightConstraint.constant = buttonsHeightConstraint.constant * 0.8
            connectWithFacebookButton.titleLabel?.font = UIFont(name: "OpenSans", size: 10.0)
            bottomConstraint.constant = bottomConstraint.constant * 0.5
            bottomLogoConstraint.constant = bottomLogoConstraint.constant * 0.5
        }
        //Specific constraints for iPhone PLUS
        if(UIScreen.main.bounds.size.height == 736){
            buttonsHeightConstraint.constant = buttonsHeightConstraint.constant * 1.2
            radioButtonHeightConstraint.constant = radioButtonHeightConstraint.constant * 1.4
        }
    }
    

    @IBAction func radioButtonTap(_ sender: CustomRadioButton) {
        sender.isSelected = !sender.isSelected
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
