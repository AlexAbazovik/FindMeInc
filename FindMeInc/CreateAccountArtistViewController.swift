import UIKit

class CreateAccountArtistViewController: UIViewController {
    
    @IBOutlet weak var radioButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var connectWithFacebookButton: UIButton!
    @IBOutlet weak var buttonsHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var refferedByTextField: UITextField!
    
    @IBOutlet weak var termsAndConditionsButton: CustomRadioButton!
    
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
    
    //MARK: Register new artist
    @IBAction func registerNewArtist(_ sender: UIButton){
        if termsAndConditionsButton.isSelected {
            MySession.sharedInfo.registerNewUser(userName: usernameTextField.text!, emailAddress: emailTextField.text!, password: passwordTextField.text!, referredBy: refferedByTextField.text!,onSuccess: { (response) in
                if response.object(forKey: "status") as! Int == 200{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    self.present(storyboard.instantiateViewController(withIdentifier: "MainNavigationScene"), animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Warning", message: response.value(forKey: "message") as? String, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }) { (error) in
                print(error)
            }
        }else{
            let alert = UIAlertController(title: "Warning.", message: "You need check terms and conditions button!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: Register new artist with facebook
    @IBAction func connectWithFacebookButtonTap( _ sender: UIButton){
        if termsAndConditionsButton.isSelected{
            let loginManager = FBSDKLoginManager()
            loginManager.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
                if error != nil{
                    let alert = UIAlertController(title: "Warning.", message: (error as! String), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else if (result?.isCancelled)!{
                    print("Cancelled")
                }else{
                    let FBRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name, email"])
                    FBRequest?.start(completionHandler: { (_ , response, error) in
                        if error != nil{
                            print(error as! String)
                        }else{
                            MySession.sharedInfo.registerNewUser(userName: (response as! NSDictionary).value(forKey: "email") as! String, emailAddress: (response as! NSDictionary).value(forKey: "email") as! String, password: "Facebook", registerWithFacebook: true, onSuccess: { (response) in
                                if response.object(forKey: "status") as! Int == 200{
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    self.present(storyboard.instantiateViewController(withIdentifier: "MainNavigationScene"), animated: true, completion: nil)
                                }else{
                                    let alert = UIAlertController(title: "Warning", message: response.value(forKey: "message") as? String, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }, onFailure: { (error) in
                                print(error)
                            })
                        }
                    })
                }
            }
        }else{
            let alert = UIAlertController(title: "Warning.", message: "You need check terms and conditions button!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
