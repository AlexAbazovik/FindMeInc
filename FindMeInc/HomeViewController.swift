import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var heightButtonConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MySession.sharedInfo.getState(onSuccess: { (result) in
            Data.sharedInfo.states = result
        }) { (error) in
            print(error)
        }
        
        //MARK: Specific constraints for iPhone 5 and SE
        if(UIScreen.main.bounds.size.height == 568){
            heightButtonConstraints.constant = heightButtonConstraints.constant * 0.8
        }
        //MARK: Specific constraints for iPhone PLUS
        if(UIScreen.main.bounds.size.height == 736){
            heightButtonConstraints.constant = heightButtonConstraints.constant * 1.2
        }
        
        UserDefaults.standard.removeObject(forKey: "userID")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //If the user has already granted permissions an application
        if FBSDKAccessToken.current() != nil{
            sendRequestToFacebook()
            /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.present(storyboard.instantiateViewController(withIdentifier: "MainNavigationScene"), animated: true, completion: nil)*/
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Use application as a guest
    @IBAction func useApplicationUsAGuestTap(_ sender: UIButton) {
        UserDefaults.standard.set(sender.tag, forKey: "userType")
    }
    
    //MARK: Send request to facebook
    func sendRequestToFacebook(){
        let FBRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":" email"])
        FBRequest?.start(completionHandler: { (_, response, error) in
            if error != nil{
                print(error)
            }else{
                print(response as! NSDictionary)
                MySession.sharedInfo.loginUser(emailAddress: (response as! NSDictionary).value(forKey: "email") as! String, password: "Facebook", onSuccess: { (response) in
                    if response.object(forKey: "status") as! Int == 200{
                        UserDefaults.standard.set((response.value(forKey: "data") as! NSDictionary).value(forKey: "id"), forKey: "userID")
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
    
    //MARK: Login with facebook
    @IBAction func loginWithFacebook( _ sender:UIButton){
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
            if error != nil{
                let alert = UIAlertController(title: "Warning.", message: (error as! String), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else if (result?.isCancelled)!{
                print("Cancelled")
            }else{
                self.sendRequestToFacebook()
            }
        }
    }
}
