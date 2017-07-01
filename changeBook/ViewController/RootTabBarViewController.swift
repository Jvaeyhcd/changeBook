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
        
        self.view.backgroundColor = UIColor.white
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.image = UIImage(named: "tab_shouye")
        homeVC.tabBarItem.selectedImage = UIImage(named: "tab_shouye_pre")
        homeVC.title = "首页"
        
        let teacherVC = TeacherHomeViewController()
        teacherVC.tabBarItem.image = UIImage(named: "tab_laoshi")
        teacherVC.tabBarItem.selectedImage = UIImage(named: "tab_laoshi_pre")
        teacherVC.title = "教师"
        
        let friendsVC = FriendsHomeViewController()
        friendsVC.tabBarItem.image = UIImage(named: "tab_shuyou")
        friendsVC.tabBarItem.selectedImage = UIImage(named: "tab_shuyou_pre")
        friendsVC.title = "书友"
        
        let articleVC = ArticleHomeViewController()
        articleVC.tabBarItem.image = UIImage(named: "tab_zixun")
        articleVC.tabBarItem.selectedImage = UIImage(named: "tab_zixun_pre")
        articleVC.title = "文章"
        
        let nav1 = BaseNavigationController.init(rootViewController: homeVC)
        let nav2 = BaseNavigationController.init(rootViewController: friendsVC)
        let nav3 = BaseNavigationController.init(rootViewController: articleVC)
        let nav4 = BaseNavigationController.init(rootViewController: teacherVC)
        
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
