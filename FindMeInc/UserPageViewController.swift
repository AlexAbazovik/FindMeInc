//
//  UserPageViewController.swift
//  FindMeInc
//
//  Created by Alex Vecher on 02.03.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class UserPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var userIDFromSegue: Int!
    
    //images
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    //user info
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var studios: UILabel!
    @IBOutlet var userInfo: [UILabel]!
    @IBOutlet weak var about: UITextView!
    
    //user images
    var userImages: [NSDictionary]!
    var squad: [NSDictionary]!
    var followers: [NSDictionary]!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var infoViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var staffCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var staffCollectionView: UICollectionView!
    @IBOutlet weak var userImagesCollectionView: UICollectionView!
    
    var segmentedControl: UISegmentedControl!
    
    //MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2.0
        
        infoViewHeightConstraint.constant = 0.0
        
        userImages = Array()
        squad = Array()
        followers = Array()
        
        //TODO: - TODO
        if (UserDefaults.standard.object(forKey: "userID") as! Int != userIDFromSegue) {
            loadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
         //TODO: - TODO
        if (UserDefaults.standard.object(forKey: "userID") as! Int == userIDFromSegue) {
            loadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        //self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        //self.navigationController?.navigationBar.isTranslucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Load user data from server
    func loadData() -> Void {
        print(userIDFromSegue)
        MySession.sharedInfo.getUserInfo(userID: userIDFromSegue, onSuccess: { (dict) in
            print(dict)
            self.avatarImageView.kf.setImage(with: URL.init(string: (dict.value(forKey: "avatar") as? String)!))
            self.coverImageView.kf.setImage(with: URL.init(string: (dict.value(forKey: "cover_photo") as? String)!))
            
            self.userName.text = dict.value(forKey: "username") as? String
            self.studios.text = dict.value(forKey: "studio") as? String
            
            self.userInfo[0].text = dict.value(forKey: "address") as? String
            self.userInfo[1].text = dict.value(forKey: "phone") as? String
            self.userInfo[2].text = dict.value(forKey: "email") as? String
            self.userInfo[3].text = dict.value(forKey: "parlor") as? String
            
            self.about.text = dict.value(forKey: "about") as? String
            
            self.userImages = dict.value(forKey: "photos") as? Array
            if (dict.value(forKey: "usertype") as! Int) == 2 {
                self.squad = dict.value(forKey: "squad") as? Array
                self.staffCollectionView.reloadData()
                self.actionShowStaffCollectionView()
            } else {
                self.followers = dict.value(forKey: "followers") as? Array
            }
            
            self.userImagesCollectionView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
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
    
    //MARK: - Actions
    @IBAction func actionShowInfoView(_ sender: UIButton) {
        infoViewHeightConstraint.constant = 200.0
        UIView.animate(withDuration: 0.3, animations: { 
            self.view.layoutIfNeeded()
        }) { (true) in
            UIView.animate(withDuration: 0.3, animations: { 
                self.infoView.subviews[0].alpha = 1.0
                self.moreInfoButton.alpha = 0.0
            })
        }
    }
    
    @IBAction func actionHideInfoView(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { 
            self.infoView.subviews[0].alpha = 0.0
            self.moreInfoButton.alpha = 1.0
        }) { (true) in
            self.infoViewHeightConstraint.constant = 0.0
            UIView.animate(withDuration: 0.3, animations: { 
                self.view.layoutIfNeeded()
            })
        }
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
    
    //staffCollectionView animations
    func actionShowStaffCollectionView() {
        self.staffCollectionViewHeightConstraint.constant = 80.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func actionHideStaffCollectionView() {
        self.staffCollectionViewHeightConstraint.constant = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
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
