import UIKit

class CreateAccountParlorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var termsAndConditionsButton: CustomRadioButton!
    @IBOutlet weak var radioButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var connectWithFacebookButton: UIButton!
    @IBOutlet weak var buttonsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var parlorNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parlorNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        //MARK: Add gesture recognizer for hide keyboard
        let tapOnBackground = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap(_:)))
        let tapOnLogo = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap(_:)))
        
        background.addGestureRecognizer(tapOnBackground)
        logo.addGestureRecognizer(tapOnLogo)
        
        //Specific constraints for iPhone 5 and SE
        if(UIScreen.main.bounds.size.height == 568){
            buttonsHeightConstraint.constant = buttonsHeightConstraint.constant * 0.8
            connectWithFacebookButton.titleLabel?.font = UIFont(name: "OpenSans", size: 10.0)
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
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotification()
    }
    
    //MARK: Register for keyboard notifications
    func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification:NSNotification){
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        scrollView.contentOffset = CGPoint(x: 0.0, y: keyboardHeight/2)
    }
    
    func unregisterForKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillHide(){
        scrollView.contentOffset = CGPoint(x: 0.0, y: 0.0)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK: Hide keyboard by tap
    func hideKeyboardByTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    //MARK: Register new parlor
    @IBAction func registerNewParlor(_ sender: UIButton){
        if termsAndConditionsButton.isSelected {
            MySession.sharedInfo.registerNewUser(userName: parlorNameTextField.text!, emailAddress: emailTextField.text!, password: passwordTextField.text!, onSuccess: { (response) in
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
    
    //MARK: Register new parlor with facebook
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
