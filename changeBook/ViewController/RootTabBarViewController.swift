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
        homeVC.title = "首页"
        
        let teacherVC = TeacherHomeViewController()
        teacherVC.title = "教师"
        
        let friendsVC = FriendsHomeViewController()
        friendsVC.title = "书友"
        
        let articleVC = ArticleHomeViewController()
        articleVC.title = "文章"
        
        let nav1 = BaseNavigationController.init(rootViewController: homeVC)
        let nav2 = BaseNavigationController.init(rootViewController: teacherVC)
        let nav3 = BaseNavigationController.init(rootViewController: friendsVC)
        let nav4 = BaseNavigationController.init(rootViewController: articleVC)
        
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
