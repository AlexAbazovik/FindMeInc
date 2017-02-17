import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var heightButtonsConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.delegate = self
        password.delegate = self
        
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
}
