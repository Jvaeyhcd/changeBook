//
//  DataViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 01/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//  资料界面

import UIKit

class DataViewController: NavTabBarController {

    private var viewControllers = [UIViewController]()
    private var cates = ["推荐", "理工", "社科", "教辅", "课外"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "资料"
        self.view.backgroundColor = kMainBgColor
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withImage: UIImage(named: "jieshu_btn_sousuo")!)
        
        self.tabBar.delegate = self
        self.view.addSubview(self.tabBar)
        
        
        self.scrollView.delegate = self.tabBar
        self.view.insertSubview(self.scrollView, belowSubview: self.tabBar)
        
        self.tabBar.setItemFontChangeFollowContentScroll(itemFontChangeFollowContentScroll: true)
        self.tabBar.setItemColorChangeFollowContentScroll(itemColorChangeFollowContentScroll: true)
        self.tabBar.showSelectedBgView(show: true)
        self.tabBar.setItemTitleFont(itemTitleFont: kBaseFont)
        self.tabBar.setItemTitleSelectedFont(itemTitleSelectedFont: kBaseFont)
        self.tabBar.setItemTitleSelectedColor(itemTitleSelectedColor: kMainColor!)
        self.tabBar.setItemSelectedBgImageViewColor(itemSelectedBgImageViewColor: kMainColor!)
        self.tabBar.setItemWidth(itemWidth: kScreenWidth / 5)
        let padding = scaleFromiPhone6Desgin(x: 10)
        self.tabBar.setItemSelectedBgInsets(itemSelectedBgInsets: UIEdgeInsetsMake(kSegmentBarHeight - 2, padding, 0, padding))
        self.tabBar.setFramePadding(top: 0, left: 0, bottom: 0, right: 0)
        
        setTabBarFrame(tabBarFrame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kSegmentBarHeight),
                       contentViewFrame: CGRect.init(x: 0, y: kSegmentBarHeight, width: kScreenWidth, height: kScreenHeight - kSegmentBarHeight))
        
        updateViewControllers()
    }
    
    // 更新ViewControllers
    private func updateViewControllers() {
        
        
        if self.viewControllers.count > 0 {
            self.viewControllers.removeAll()
        }
        
        for cate in self.cates {
            
            let vc = DataListViewController()
            vc.parentVC = self
            vc.title = cate
            viewControllers.append(vc)
            
        }
        
        self.setViewControllers(viewControllers: self.viewControllers)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
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
