//
//  MainTabBarController.swift
//  FindMeInc
//
//  Created by Alexandr on 2/14/17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    @IBOutlet weak var mainTabBar: UITabBar!
    
    
    //MARK: - UIVIewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.items?.first?.image = #imageLiteral(resourceName: "FMI_All_Star_Icon")
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let userPage = (viewController as! UINavigationController).viewControllers[0]
        if userPage is UserPageTableViewController {
            (userPage as! UserPageTableViewController).userIDFromSegue = UserDefaults.standard.object(forKey: "userID") as! Int!
        }
        return true
    }

}
