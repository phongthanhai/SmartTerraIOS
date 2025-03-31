//
//  MainTabBarViewController.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 11/11/2024.
//

import Foundation
import UIKit

class MainTabBarVC: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dashboardVC = TerrariumDashboardVC()
        let wateringVC  = WateringVC()
        let settingVC   = SettingVC()
        let profileVC   = ProfileVC()
        let fanVC       = FanVC()
        
        dashboardVC.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "house.fill"), tag: 0)
        
        wateringVC.tabBarItem = UITabBarItem(title: "Water", image:
            UIImage(systemName: "sprinkler.and.droplets.fill"), tag: 1)
        
        settingVC.tabBarItem = UITabBarItem(title: "Setting", image:
            UIImage(systemName: "gearshape.fill"),tag:2)
        
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image:
            UIImage(systemName: "person.fill"),tag:3)
        
        fanVC.tabBarItem = UITabBarItem(title: "Fan", image: UIImage(systemName: "fan.desk.fill"), tag: 4)
        
        
        
        self.viewControllers = [dashboardVC,wateringVC,fanVC,settingVC,profileVC]
    }
    
    
}
