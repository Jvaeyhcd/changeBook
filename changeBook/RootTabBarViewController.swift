//
//  RootTabBarViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initSubviews() {
        //        UITabBar.appearance().tintColor = kTabbarTintColor
        
        let chargeVC = UIViewController()
        chargeVC.title = "首页"
        
        let circleVC = UIViewController()
        circleVC.title = "老师"
        
        let serviceVC = UIViewController()
        serviceVC.title = "书友"
        
        let mineVC = UIViewController()
        mineVC.title = "文章"
        
        let nav1 = BaseNavigationController.init(rootViewController: chargeVC)
        let nav2 = BaseNavigationController.init(rootViewController: circleVC)
        let nav3 = BaseNavigationController.init(rootViewController: serviceVC)
        let nav4 = BaseNavigationController.init(rootViewController: mineVC)
        
        self.viewControllers = [nav1, nav2, nav3, nav4]
        
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
