//
//  BookListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 01/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class BorrowBookViewController: NavTabBarController {
    
    private var viewControllers = [UIViewController]()
    private var cates = ["推荐", "理工", "社科", "教辅", "课外"]
    private var filters = [kBookFilterRecommend, kBookFilterPolytechnic, kBookFilterSocial, kBookFilterSupplementary, kBookFilterExtracurricular]

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "借书"
        self.view.backgroundColor = kMainBgColor
        self.showBackButton()
        
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        searchBtn.setImage(UIImage(named: "jieshu_btn_sousuo"), for: .normal)
        searchBtn.addTarget(self, action: #selector(goToSearchBook), for: .touchUpInside)
        let searchBarBtn = UIBarButtonItem.init(customView: searchBtn)
        
        let bagBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        bagBtn.setImage(UIImage(named: "home_btn_shubao"), for: .normal)
        bagBtn.addTarget(self, action: #selector(bagBtnClicked), for: .touchUpInside)
        let bagBarBtn = UIBarButtonItem.init(customView: bagBtn)
        
        //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -10;
        
        self.navigationItem.rightBarButtonItems = [spacer, bagBarBtn, searchBarBtn]
        
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
                       contentViewFrame: CGRect.init(x: 0, y: kSegmentBarHeight, width: kScreenWidth, height: kScreenHeight - kSegmentBarHeight - kNavHeight))
        
        updateViewControllers()
    }
    
    // 更新ViewControllers
    private func updateViewControllers() {
        
        
        if self.viewControllers.count > 0 {
            self.viewControllers.removeAll()
        }
        
        for i in 0..<self.cates.count {
            
            let cate = self.cates[i]
            let filter = self.filters[i]
            
            let vc = BookListViewController()
            vc.parentVC = self
            vc.bookType = filter
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

    @objc private func goToSearchBook() {
        let vc = SearchBookViewController()
        self.pushViewController(viewContoller: vc, animated: true)
    }
    
    @objc private func bagBtnClicked() {
        let vc = BagViewController()
        self.pushViewController(viewContoller: vc, animated: true)
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
