import UIKit

class CreateAccountCustomerViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var connectWithFacebookButton: UIButton!
    @IBOutlet weak var buttonsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var radioButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var termsAndConditionsButton: CustomRadioButton!
    @IBOutlet weak var customerNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    
    var stateCode: String?
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Add gesture recognizer for hide keyboard
        let tapOnBackground = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap(_:)))
        let tapOnLogo = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap(_:)))
        
        background.addGestureRecognizer(tapOnBackground)
        logo.addGestureRecognizer(tapOnLogo)
        
        // MARK: Add picker view
        //Add picker view to select the state
        
        let statePickerView = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 200))
        statePickerView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        
        statePickerView.delegate = self
        statePickerView.dataSource = self
        
        //Add toolbar to control the picker view
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = #colorLiteral(red: 0.8980392157, green: 0.6156862745, blue: 0.3803921569, alpha: 1)
        toolBar.sizeToFit()
        
        //Add buttons to the toolbar
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateAccountCustomerViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateAccountCustomerViewController.donePicker))
        cancelButton.tag = 1
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        stateTextField.inputView = toolBar
        stateTextField.inputAccessoryView = statePickerView
        
        customerNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        cityTextField.delegate = self
        stateTextField.delegate = self
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotification()
    }
    
    @IBAction func radioButtonTap(_ sender: CustomRadioButton) {
        sender.isSelected = !sender.isSelected
    }

    
    // MARK: Register for keyboard notifications
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
    
    //MARK: Unregister for keyboard notifications
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
    
    //MARK: Hide keyboard by tap on Screen
    @IBAction func hideKeyboardByTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    //MARK: Picker view data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Data.sharedInfo.states!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (Data.sharedInfo.states?.allValues[row] as! String)
    }
    
    //MARK: Picker view delegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stateTextField.text = (Data.sharedInfo.states?.allValues[row] as! String)
        stateCode = (Data.sharedInfo.states?.allKeys[row] as! String)
    }
    
    func donePicker(_ sender: UIButton){
        if sender.tag == 1{
            stateTextField.text = ""
        }
            self.view.endEditing(true)
    }
    
    //MARK: Register new customer
    @IBAction func registerNewCustomer(_ sender: UIButton){
        if termsAndConditionsButton.isSelected {
            MySession.sharedInfo.registerNewUser(userName: customerNameTextField.text!, emailAddress: emailTextField.text!, password: passwordTextField.text!, state: stateCode, city: cityTextField.text!, onSuccess: { (response) in
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
    
    //MARK: Register new customer with facebook
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
