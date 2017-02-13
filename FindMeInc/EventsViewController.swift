import UIKit

class EventsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var conventionsCollectionView: UICollectionView!
    @IBOutlet weak var localEventsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conventionsCollectionView.delegate = self
        conventionsCollectionView.dataSource = self
        
        localEventsCollectionView.delegate = self
        localEventsCollectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = conventionsCollectionView.dequeueReusableCell(withReuseIdentifier: "eventsCollectionViewCell", for: indexPath) as! EventCollectionViewCell
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
