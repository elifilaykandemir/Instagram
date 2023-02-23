//
//  TabBarViewController.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 2.02.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Define view controller
        let home = HomeViewController()
        let camera = CameraViewController()
        let explorer = ExplorerViewController()
        let activity = NotificationViewController()
        let profile = ProfileViewController()
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: camera)
        let nav3 = UINavigationController(rootViewController: explorer)
        let nav4 = UINavigationController(rootViewController: activity)
        let nav5 = UINavigationController(rootViewController: profile)
        
        // Define tab items
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Camera", image: UIImage(systemName: "camera"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Explorer", image: UIImage(systemName: "safari"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Notification", image: UIImage(systemName: "bell"), tag: 4)
        nav5.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 5)
        
        //Set Controller
        self.setViewControllers([nav1,nav3,nav2,nav4,nav5], animated: false)
    }
    

}
