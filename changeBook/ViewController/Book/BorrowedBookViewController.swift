//
//  BorrowedBookViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 28/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class BorrowedBookViewController: NavTabBarController {
    
    private var viewControllers = [UIViewController]()
    private var cates = ["全部", "待发货", "待收货", "借阅中", "已逾期", "已归还"];
    private var orderStatus = [0, kOrderStatusDaiFaHuo, kOrderStatusDaiShouHuo, kOrderStatusJieYueZhong, kOrderStatusYuQi, kOrderStatusDone]

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "我的借阅"
        self.view.backgroundColor = kMainBgColor
        self.showBackButton()
        
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
        let padding = scaleFromiPhone6Desgin(x: 4)
        self.tabBar.setItemSelectedBgInsets(itemSelectedBgInsets: UIEdgeInsetsMake(kSegmentBarHeight - 2, padding, 0, padding))
        self.tabBar.setFramePadding(top: 0, left: 0, bottom: 0, right: 0)
        
        setTabBarFrame(tabBarFrame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kSegmentBarHeight),
                       contentViewFrame: CGRect.init(x: 0, y: kSegmentBarHeight, width: kScreenWidth, height: kScreenHeight - kSegmentBarHeight - kNavHeight))
        
        updateViewControllers()
    }
    
    private func updateViewControllers() {
        
        
        if self.viewControllers.count > 0 {
            self.viewControllers.removeAll()
        }
        
        for i in 0..<self.cates.count {
            let cate = self.cates[i]
            let status = self.orderStatus[i]
            let vc = BookOrderListViewController()
            vc.parentVC = self
            vc.orderStatus = status
            vc.title = cate
            viewControllers.append(vc)

        }
        
        self.setViewControllers(viewControllers: self.viewControllers)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        
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
