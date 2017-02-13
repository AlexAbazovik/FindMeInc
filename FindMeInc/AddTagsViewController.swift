import UIKit

class AddTagsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var tagsTableView: UITableView!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MySession.sharedInfo.tagsCollection.removeAll()
        
        tagsTableView.dataSource = self
        tagsTableView.delegate = self
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tagsTableView.dequeueReusableCell(withIdentifier: "tagsTableViewCell", for: indexPath) as! TagsTableViewCell
        tagsCollectionView.reloadData()
        if indexPath.row == 1{
            cell.tagLabel.text = "#BlackAndWhite"
        }
        if indexPath.row == 2{
            cell.tagLabel.text = "#Convention"
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
            return MySession.sharedInfo.tagsCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagsCollectionView.dequeueReusableCell(withReuseIdentifier: "tagCollectionViewCell", for: indexPath) as! TagsCollectionViewCell
        cell.label.text = MySession.sharedInfo.tagsCollection[indexPath.row]
        return cell
    }
}
