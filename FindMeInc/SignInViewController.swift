import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var heightButtonsConstraints: NSLayoutConstraint!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.delegate = self
        password.delegate = self
        
        //MARK: Add gesture recognizer for hide keyboard
        let tapOnBackground = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap(_:)))
        let tapOnLogo = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap(_:)))
        
        background.addGestureRecognizer(tapOnBackground)
        logo.addGestureRecognizer(tapOnLogo)
        
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
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotification()
    }
    
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
    
    //MARK: Hide keyboard by Tap
    @IBAction func hideKeyboardByTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonTap( _ sender: UIButton){
        MySession.sharedInfo.loginUser(emailAddress: userName.text!, password: password.text!, onSuccess: { (response) in
            if response.object(forKey: "status") as! Int == 200{
                UserDefaults.standard.set((response.value(forKey: "data") as! NSDictionary).value(forKey: "id"), forKey: "userID")
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
    }
}
