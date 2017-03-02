//
//  UserPageViewController.swift
//  FindMeInc
//
//  Created by Alex Vecher on 02.03.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class UserPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var infoViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var staffCollectionView: UICollectionView!
    @IBOutlet weak var userImagesCollectionView: UICollectionView!
    
    //MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        infoViewHeightConstraint.constant = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        if collectionView == self.staffCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "staffCollectionCell", for: indexPath)
            cell.backgroundColor = UIColor.black
        } else if collectionView == self.userImagesCollectionView {
            if indexPath.row == 0 && indexPath.section == 0 {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellWithButton",
                                                          for: indexPath)
            } else {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "usualCell",
                                                          for: indexPath)
                cell.backgroundColor = UIColor.gray
            }
        }
        
        return cell
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
