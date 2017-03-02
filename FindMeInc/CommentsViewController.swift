import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    //MARK: Outlets

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var chatCount: UILabel!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var inputTextView: UITextView!
    
    //MARK: Data from tatto details view controller
    var photoID: Int?
    var userType: Int?
    
    
    var viewCenter: CGPoint?
    
    //Temp data
    /*
    var chatInfo: NSDictionary = [
        "isLiked" : true,
        "likesCount" : "12",
        "chatCount" : "3",
        "info" : [
            [
                "commentatorID" : "1",
                "avatarURL" : "https://s-media-cache-ak0.pinimg.com/originals/d4/e7/aa/d4e7aa60eb6a782d5d25340debaa1ad6.jpg",
                "name" : "STEVE BRULE",
                "message" : "Hi! It's a good idea! Nice!",
                "date" : "3 Jan 2017 @ 10:41"
            ],
            [
                "commentatorID" : "2",
                "avatarURL" : "https://s-media-cache-ak0.pinimg.com/originals/d4/e7/aa/d4e7aa60eb6a782d5d25340debaa1ad6.jpg",
                "name" : "TIM HEIDECKER",
                "message" : "GREAT!",
                "date" : "3 Jan 2017 @ 10:51"
            ]
        ]
    ]
    */
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCenter = self.view.center
        
        inputTextView.delegate = self
        messageTableView.dataSource = self
        messageTableView.delegate = self
        
        //MARK: Remove white area from Table view
        self.automaticallyAdjustsScrollViewInsets = false
        
        let tapOnTableView = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTap(_:)))
        messageTableView.addGestureRecognizer(tapOnTableView)
        
        loadData()
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
        
        self.view.center = CGPoint(x: self.view.center.x, y: self.view.center.y - keyboardHeight/2)
        if inputTextView.text == "Write something..."{
            inputTextView.text = ""
            inputTextView.textColor = #colorLiteral(red: 0.2588235294, green: 0.2549019608, blue: 0.2588235294, alpha: 1)
        }
    }
    
    func unregisterForKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillHide(){
        self.view.center = viewCenter!
    }
    
    //MARK: Hide keyboard by tap
    func hideKeyboardByTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: messageTableView)
        let path = messageTableView.indexPathForRow(at: location)
        if path == nil{
            if inputTextView.text == "" {
                inputTextView.text = "Write something..."
                inputTextView.textColor = #colorLiteral(red: 0.5764705882, green: 0.5843137255, blue: 0.5960784314, alpha: 1)
            }
            self.view.endEditing(true)
        }
    }
    
    //MARK: Message table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Data.sharedInfo.chatInfo != nil{
            return (Data.sharedInfo.chatInfo!.value(forKey: "info") as! NSArray).count
        }else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let elementInfo = (Data.sharedInfo.chatInfo?.value(forKey: "info") as! NSArray)[indexPath.row] as! NSDictionary
        let avatar = elementInfo.value(forKey: "avatarURL")
        let avatarURL = URL.init(string: avatar as! String)
        let cell = messageTableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentsTableViewCell
        cell.avatar.kf.setImage(with: avatarURL)
        cell.name.text = elementInfo.value(forKey: "name") as! String?
        cell.message.text = elementInfo.value(forKey: "message") as! String?
        cell.date.text = elementInfo.value(forKey: "date") as! String?
        return cell
    }
    
    //MARK: load data
    func loadData(){
        MySession.sharedInfo.getComents(photoID: photoID!, onSuccess: { (response) in
            Data.sharedInfo.chatInfo = response
            print(Data.sharedInfo.chatInfo?.value(forKey: "isLiked") as! Bool)
            self.likeButton.isSelected = Data.sharedInfo.chatInfo?.value(forKey: "isLiked") as! Bool
            self.likesCount.text = Data.sharedInfo.chatInfo?.value(forKey: "likesCount") as? String
            self.chatCount.text = Data.sharedInfo.chatInfo?.value(forKey: "chatCount") as? String
            self.messageTableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    //MARK: Like button tap
    //TO DO: Send button state on the server
    @IBAction func like(_ sender: UIButton){
        MySession.sharedInfo.photoLike(photoID: photoID!, userID: UserDefaults.standard.value(forKey: "userID") as! Int)
        if sender.isSelected{
            likesCount.text = String(Int(likesCount.text!)! - 1)
        }else{
            likesCount.text = String(Int(likesCount.text!)! + 1)
        }
        sender.isSelected = !sender.isSelected
    }
    
    //MARK: Sent comment to the server
    @IBAction func sendComment(){
        if inputTextView.text != "" {
            MySession.sharedInfo.sendComment(photoID: photoID!, message: inputTextView.text, onSuccess: { (response) in
                if response {
                    self.loadData()
                }
            })
        } else {
            let alert = UIAlertController(title: "Warning", message: "You need write some message.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
