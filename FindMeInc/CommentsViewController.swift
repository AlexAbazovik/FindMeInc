import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Outlets

    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var chatCount: UILabel!
    @IBOutlet weak var messageTableView: UITableView!
    
    //MARK: Data from tatto details view controller
    var photoID: Int?
    var userType: Int?
    
    //Temp data
    var chatInfo: NSDictionary = [
        "isLicked" : true,
        "lickesCount" : 12,
        "chatCount" : 3,
        "info" : [
            [
                "avatarURL" : "https://www.google.by/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwikzrnt5K_SAhWMBZoKHf0ACTcQjRwIBw&url=https%3A%2F%2Fwww.pinterest.com%2Fadam_hector%2Fit-ed-avatar-for-im%2F&psig=AFQjCNF2Od_a47zQt-NSW0oBb7N9JbhXFw&ust=1488268094441983",
                "name" : "STEVE BRULE",
                "message" : "Hi! It's a good idea! Nice!",
                "date" : "3 Jan 2017 @ 10:41"
            ],
            [
                "avatarURL" : "https://www.google.by/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwikzrnt5K_SAhWMBZoKHf0ACTcQjRwIBw&url=https%3A%2F%2Fwww.pinterest.com%2Fadam_hector%2Fit-ed-avatar-for-im%2F&psig=AFQjCNF2Od_a47zQt-NSW0oBb7N9JbhXFw&ust=1488268094441983",
                "name" : "TIM HEIDECKER",
                "message" : "GREAT!",
                "date" : "3 Jan 2017 @ 10:51"
            ]
        ]
    ]
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.dataSource = self
        messageTableView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //MARK: Message table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (chatInfo.value(forKey: "info") as! NSArray).count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let avatar = ((chatInfo.value(forKey: "info") as! NSArray)[indexPath.row] as! NSDictionary).value(forKey: "avatar")
        let cell = messageTableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentsTableViewCell
        return cell
    }
    
    //MARK: load data
    func loadData(){
        
    }
}
