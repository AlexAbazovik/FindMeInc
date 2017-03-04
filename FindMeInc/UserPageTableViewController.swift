//
//  UserPageTableViewController.swift
//  FindMeInc
//
//  Created by Alex Vecher on 04.03.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class UserPageTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var userIDFromSegue: Int!
    
    let refresher = UIRefreshControl()
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    //user info cell
    @IBOutlet var userInfo: [UILabel]!
    @IBOutlet weak var about: UITextView!
    //user info cell
    private var userInfoCellHeight: CGFloat = 23.0
    private var userInfoSelectedCellHeight: CGFloat = 223.0
    private var isSelected: Bool = false
    
    //staff cell
    private var cellHeight: CGFloat = 0.001
    private var selectedCellHeight: CGFloat = 80
    private var isParlor: Bool = false
    
    //data
    var userImages: [NSDictionary]!
    var squad: [NSDictionary]!
    var followers: [NSDictionary]!
    
    @IBOutlet weak var staffCollectionView: UICollectionView!
    @IBOutlet weak var userImagesCollectionView: UICollectionView!
    
    //MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2.0
        
        userImages = Array()
        squad = Array()
        followers = Array()
        print(userIDFromSegue)
        //TODO: - TODO
        if (UserDefaults.standard.object(forKey: "userID") as! Int != userIDFromSegue) {
            loadData()
        } else {
            self.navigationController?.isNavigationBarHidden = true
        }
        
        //MARK: Add refresher on the collection view
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refresher)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //TODO: - TODO
        if (UserDefaults.standard.object(forKey: "userID") as! Int == userIDFromSegue) {
            loadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (UserDefaults.standard.object(forKey: "userID") as! Int != userIDFromSegue) {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (UserDefaults.standard.object(forKey: "userID") as! Int != userIDFromSegue) {
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Data
    func getInfo() -> Void {
        MySession.sharedInfo.getUserInfo(userID: userIDFromSegue, onSuccess: { (dict) in
            print(dict)
            self.avatarImageView.kf.setImage(with: URL.init(string: (dict.value(forKey: "avatar") as? String)!))
            self.coverImageView.kf.setImage(with: URL.init(string: (dict.value(forKey: "cover_photo") as? String)!))
            
            self.userInfo[0].text = dict.value(forKey: "username") as? String
            self.userInfo[1].text = dict.value(forKey: "studio") as? String
            
            self.userInfo[2].text = dict.value(forKey: "address") as? String
            self.userInfo[3].text = dict.value(forKey: "phone") as? String
            self.userInfo[4].text = dict.value(forKey: "email") as? String
            self.userInfo[5].text = dict.value(forKey: "parlor") as? String
            
            self.about.text = dict.value(forKey: "about") as? String
            
            self.userImages = dict.value(forKey: "photos") as? Array
            if (dict.value(forKey: "usertype") as! Int) == 2 {
                self.isParlor = true
                
                self.squad = dict.value(forKey: "squad") as? Array
                self.staffCollectionView.reloadData()
            } else {
                self.followers = dict.value(forKey: "followers") as? Array
            }
            
            self.userImagesCollectionView.reloadData()
            
            self.tableView.reloadData()
            
            self.refresher.endRefreshing()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Load user data from server
    func loadData() -> Void {
        print(userIDFromSegue)
        getInfo()
    }
    
    //Refresh data in newsfeed
    func refreshData() {
        getInfo()
    }
    
    //MARK: - UISegmentedControl
    func setSegmentedControlWith(_ type: Int, _ userID: String) -> UISegmentedControl {
        var segmented = UISegmentedControl()
        
        if type == 1 {
            if ((UserDefaults.standard.object(forKey: "userID") as! String) == userID) {
                segmented = UISegmentedControl.init(items: ["TATTOOS", "APPOINTMENTS", "MY EVENTS", "FOLLOWERS"])
            } else {
                segmented = UISegmentedControl.init(items: ["TATTOOS", "APPOINTMENTS", "MESSAGE", "MY EVENTS", "FOLLOWERS"])
            }
        }
        
        return segmented
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath.row == 1) {
            if (isSelected) {
                isSelected = false
            } else {
                isSelected = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
            tableView.cellForRow(at: indexPath)?.layoutIfNeeded()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0.0
        switch indexPath.row {
        case 0:
            height = 200
            break
        case 1:
            if (isSelected) {
                height = userInfoSelectedCellHeight
            } else {
                height = userInfoCellHeight
            }
            break
        case 2:
            if (isParlor) {
                height = selectedCellHeight
            } else {
                height = cellHeight
            }
            break
        case 3:
            height = 31.0
            break
        case 4:
            height = (CGFloat(userImages.count - 1) / 3.0) * (self.view.bounds.width / 3.0)
            if (height < self.view.bounds.width / 3.0) {
                height = self.view.bounds.width / 3.0
            }
            break
        default:
            break
        }
        return height
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.userImagesCollectionView {
            if ((UserDefaults.standard.object(forKey: "userID") as! Int) == userIDFromSegue) {
                return userImages!.count + 1
            } else {
                return userImages!.count
            }
        } else if collectionView == self.staffCollectionView {
            return squad!.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        if collectionView == self.staffCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "staffCollectionCell", for: indexPath)
            let url = URL.init(string: squad[indexPath.row].object(forKey: "avatar") as! String)
            (cell.contentView.subviews[0] as! UIImageView).kf.setImage(with: url)
        } else if collectionView == self.userImagesCollectionView {
            //cell.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width / 3.0, height: self.view.bounds.width / 3.0)
            if (UserDefaults.standard.object(forKey: "userID") as! Int == userIDFromSegue) {
                if indexPath.row == 0 && indexPath.section == 0 {
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellWithButton",
                                                              for: indexPath)
                } else {
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "usualCell",
                                                              for: indexPath)
                    let url = URL.init(string: squad[indexPath.row - 1].object(forKey: "photo_url") as! String)
                    (cell.contentView.subviews[0] as! UIImageView).kf.setImage(with: url)
                }
            } else {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "usualCell",
                                                          for: indexPath)
                let url = URL.init(string: userImages[indexPath.row].object(forKey: "photo_url") as! String)
                (cell.contentView.subviews[0] as! UIImageView).kf.setImage(with: url)
            }
        }
        
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.staffCollectionView {
             return CGSize.init(width: 70.0, height: 70.0)
        } else {
             return CGSize.init(width: collectionView.bounds.width * 0.33, height: collectionView.bounds.width * 0.33)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt minimumLineSpacingForSectionAtIndex: NSInteger) -> CGFloat {
        return 0.0
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
