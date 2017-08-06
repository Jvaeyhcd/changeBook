//
//  OthersHomeViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 06/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class OthersHomeViewController: BaseViewController, HcdTabBarDelegate {
    
    private var usersViewModel = UserViewModel()
    // tableview的偏移量
    fileprivate var tableViewOffsetY = CGFloat(0)
    private var selectedControllerIndex = -1
    private var canotScrollIndex = -1
    private var viewControllers = [BaseTableViewController]()
    lazy var tabBar: SlippedSegmentView = {
        
        let tabBar = SlippedSegmentView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kSegmentBarHeight))
        tabBar.backgroundColor = UIColor.white
        tabBar.showSelectedBgView(show: false)
        return tabBar
        
    }()
    
    lazy var controllersScrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = kMainBgColor
        return scrollView
    }()
    
    private var contentViewFrame: CGRect?
    private var contentSwitchAnimated = true
    
    var user: User!
    
    fileprivate var userDetailViewHeight = scaleFromiPhone6Desgin(x: 180)
    
    fileprivate lazy var userDetailView: UserDetailView = {
        let view = UserDetailView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: scaleFromiPhone6Desgin(x: 180)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    private func initSubviews() {
        
        self.title = self.user.nickName
        
        var userDescLblHeight = self.user.introduce.heightWithConstrainedWidth(width: kScreenWidth - scaleFromiPhone6Desgin(x: 60), font: UIFont.systemFont(ofSize: 13))
        
        userDescLblHeight = userDescLblHeight > scaleFromiPhone6Desgin(x: 20) ? userDescLblHeight : scaleFromiPhone6Desgin(x: 20)
        
        self.userDetailViewHeight = userDescLblHeight + scaleFromiPhone6Desgin(x: 100) + 2 * kBasePadding
        
        self.showBackButton()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tabBar.delegate = self
        self.view.addSubview(self.tabBar)
        
        setupFrameOfTabBarAndContentView()
        
        self.controllersScrollView.delegate = self.tabBar
        self.view.insertSubview(self.controllersScrollView, belowSubview: self.tabBar)
        
        let vc1 = UsersBrowListViewController()
        vc1.user = self.user
        vc1.tableHeaderView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: userDetailViewHeight)
        vc1.tableView.setEmptyDataSetVerticalOffset(offset: userDetailViewHeight / 2)
        vc1.parentVC = self
        vc1.title = "借阅"
        
        let vc2 = UsersBrowListViewController()
        vc2.user = self.user
        vc2.tableHeaderView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: userDetailViewHeight)
        vc2.tableView.setEmptyDataSetVerticalOffset(offset: userDetailViewHeight / 2)
        vc2.parentVC = self
        vc2.title = "评论"
        
        setTabBarFrame(tabBarFrame: CGRect(x: 0, y: userDetailViewHeight, width: kScreenWidth, height: kSegmentBarHeight), contentViewFrame: CGRect(x: 0, y: kSegmentBarHeight, width: kScreenWidth, height: kScreenHeight - kSegmentBarHeight - kTabBarHeight - kNavHeight))
        self.tabBar.setItemWidth(itemWidth: kScreenWidth / 2)
        self.tabBar.setFramePadding(top: 0, left: 0, bottom: 0, right: 0)
        self.tabBar.setItemHorizontalPadding(itemHorizontalPadding: 50)
        self.tabBar.setItemSelectedBgInsets(itemSelectedBgInsets: UIEdgeInsetsMake(kSegmentBarHeight - 2, 50, 0, 50))
        self.tabBar.showSelectedBgView(show: true)
        self.tabBar.setItemTitleSelectedFont(itemTitleSelectedFont: kBaseFont)
        self.tabBar.setItemTitleFont(itemTitleFont: kBaseFont)
        self.tabBar.setItemTitleColor(itemTitleColor: UIColor(hex: 0x555555)!)
        self.tabBar.setItemTitleSelectedColor(itemTitleSelectedColor: kMainColor!)
        self.tabBar.setItemSelectedBgImageViewColor(itemSelectedBgImageViewColor: kMainColor!)
        
        setViewControllers(viewControllers: [vc1, vc2])
        
        self.userDetailView.setUser(user: self.user)
        self.userDetailView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.userDetailViewHeight)
        self.view.addSubview(self.userDetailView)
        
    }
    
    // MARK: - Networking
    private func getUsersInfo() {
        self.usersViewModel.getUserInfo(userId: self.user.userId, success: { [weak self] (data) in
            
            self?.user = User.fromJSON(json: data.object)
            self?.userDetailView.setUser(user: (self?.user)!)
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    private func updateContentViewsFrame() {
        self.controllersScrollView.frame = self.contentViewFrame!
        
        self.controllersScrollView.contentSize = CGSize.init(width: self.contentViewFrame!.size.width * CGFloat(self.viewControllers.count), height: self.contentViewFrame!.size.height)
        
        var index = 0
        
        self.viewControllers.forEach{ controller in
            
            if controller.isViewLoaded {
                
                controller.view.frame = CGRect.init(x: CGFloat(index) * self.contentViewFrame!.size.width, y: 0, width: self.contentViewFrame!.size.width, height: self.contentViewFrame!.size.height)
            }
            
            index = index + 1
        }
        
        if nil != selectedController() {
            self.controllersScrollView.scrollRectToVisible(selectedController()!.view.frame, animated: false)
        }
    }
    
    private func selectedController() -> UIViewController? {
        if self.selectedControllerIndex >= 0 {
            return self.viewControllers[self.selectedControllerIndex]
        }
        return nil
    }
    
    private func setupFrameOfTabBarAndContentView() {
        // 设置默认的tabBar的frame和contentViewFrame
        let screenSize = UIScreen.main.bounds.size
        
        let contentViewY = kSegmentBarHeight
        let tabBarY = CGFloat(0)
        var contentViewHeight = screenSize.height - kSegmentBarHeight
        
        // 如果parentViewController为UINavigationController及其子类
        
        if nil != self.parent
            && (self.parent?.isKind(of: UINavigationController.self))!
            && nil != self.navigationController
            && !self.navigationController!.isNavigationBarHidden
            && !self.navigationController!.navigationBar.isHidden {
            let navMaxY = self.navigationController!.navigationBar.frame.maxY
            if !self.navigationController!.navigationBar.isTranslucent
                || self.edgesForExtendedLayout == .none
                || self.edgesForExtendedLayout == .top {
                contentViewHeight = screenSize.height - kSegmentBarHeight - navMaxY
            } else {
                
            }
        }
        
        self.setTabBarFrame(tabBarFrame: CGRect.init(x: 0, y: tabBarY, width: screenSize.width, height: kSegmentBarHeight),
                            contentViewFrame: CGRect.init(x: 0,
                                                          y: contentViewY,
                                                          width: screenSize.width,
                                                          height: contentViewHeight))
    }
    
    // MARK: - Setter
    
    func setSelectedControllerIndex(selectedControllerIndex: Int) {
        
        if selectedControllerIndex < 0 || selectedControllerIndex > self.viewControllers.count - 1 {
            return
        }
        
        var oldController: UIViewController?
        if self.selectedControllerIndex >= 0 {
            oldController = self.viewControllers[self.selectedControllerIndex]
        }
        let curController = self.viewControllers[selectedControllerIndex] as BaseTableViewController
        curController.tableViewOffsetY = self.tableViewOffsetY
        var isAppearFirstTime = true
        
        oldController?.viewWillDisappear(false)
        if nil == curController.view.superview {
            // superview为空，表示为第一次加载，设置frame，并添加到scrollView
            curController.view.frame = CGRect.init(x: CGFloat(selectedControllerIndex) * self.controllersScrollView.frame.size.width, y: 0, width: self.controllersScrollView.frame.size.width, height: self.controllersScrollView.frame.size.height)
            self.controllersScrollView.addSubview(curController.view)
        } else {
            // superview不为空，表示为已经加载过了，调用viewWillAppear方法
            isAppearFirstTime = false
            curController.viewWillAppear(false)
        }
        // 切换到curController
        self.controllersScrollView.scrollRectToVisible(curController.view.frame, animated: self.contentSwitchAnimated)
        
        // 当contentView为scrollView及其子类时，设置它支持点击状态栏回到顶部
        if nil != oldController && (oldController?.view.isKind(of: UIScrollView.self))! {
            (oldController!.view as! UIScrollView).scrollsToTop = false
        }
        if curController.view.isKind(of: UIScrollView.self) {
            (curController.view as! UIScrollView).scrollsToTop = true
        }
        
        self.selectedControllerIndex = selectedControllerIndex
        
        // 调用状态切换的回调方法
        
        oldController?.viewDidDisappear(false)
        if !isAppearFirstTime {
            curController.viewDidAppear(false)
        }
    }
    
    /**
     设置ViewControllers
     
     - parameter viewControllers: ViewController数组
     */
    func setViewControllers(viewControllers: [BaseTableViewController]) {
        
        if viewControllers.count == 0 {
            return
        }
        
        self.viewControllers.forEach { controller in
            controller.removeFromParentViewController()
            controller.view.removeFromSuperview()
        }
        
        var titles = [String]()
        var index = 0
        
        self.viewControllers = viewControllers
        self.viewControllers.forEach { controller in
            self.addChildViewController(controller)
            
            controller.tableView.addObserver(self,
                                             forKeyPath: "contentOffset",
                                             options: NSKeyValueObservingOptions.new,
                                             context: nil)
            var title = controller.title
            if nil == title || "" == title {
                title = "Item" + String(index + 1)
            }
            titles.append(title!)
            index = index + 1
        }
        
        self.tabBar.setTitles(titles: titles)
        
        self.tabBar.setSelectedItemIndex(selectedItemIndex: 0)
        
        // 更新scrollView的content size
        self.controllersScrollView.contentSize = CGSize.init(width: self.contentViewFrame!.size.width,
                                                             height: self.contentViewFrame!.size.height)
        
        updateContentViewsFrame()
    }
    
    // MARK: public function
    
    /**
     设置ViewController的Content Frame
     
     - parameter contentViewFrame: viewController的ScrollView的Frame
     */
    func setContentViewFrame(contentViewFrame: CGRect) {
        self.contentViewFrame = contentViewFrame
        updateContentViewsFrame()
    }
    
    /**
     设置TabBar的Frame和ContentView的Frame
     
     - parameter tabBarFrame:      tabBar的Frame
     - parameter contentViewFrame: ContentView的Frame
     */
    func setTabBarFrame(tabBarFrame: CGRect, contentViewFrame: CGRect) {
        
        self.tabBar.updateFrame(frame: tabBarFrame)
        setContentViewFrame(contentViewFrame: contentViewFrame)
    }
    
    // MARK: - HcdTabBarDelegate
    func tabBar(tabBar: SlippedSegmentView, didSelectedItemAtIndex: Int) {
        if didSelectedItemAtIndex == self.selectedControllerIndex {
            return
        }
        if didSelectedItemAtIndex == self.canotScrollIndex {
            self.controllersScrollView.isScrollEnabled = false
        } else {
            self.controllersScrollView.isScrollEnabled = true
        }
        
        self.setSelectedControllerIndex(selectedControllerIndex: didSelectedItemAtIndex)
    }
    
    func tabBar(tabBar: SlippedSegmentView, willSelectItemAtIndex: Int) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension OthersHomeViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let tableView = object as! UIRefreshTableView
        
        if keyPath != "contentOffset" {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        let tableViewoffsetY = tableView.contentOffset.y
        
        BLog(log: "tableViewoffsetY=\(tableViewoffsetY)")
        
        if ( tableViewoffsetY>=0 && tableViewoffsetY<=userDetailViewHeight) {
            
            self.tabBar.frame = CGRect(x: 0, y: userDetailViewHeight-tableViewoffsetY, width: kScreenWidth, height: kSegmentBarHeight)
            self.userDetailView.frame = CGRect(x: 0, y: 0-tableViewoffsetY, width: kScreenWidth, height: userDetailViewHeight)
            self.tableViewOffsetY = tableViewoffsetY
            
        } else if( tableViewoffsetY < 0){
            
            self.tabBar.frame = CGRect(x: 0, y: userDetailViewHeight, width: kScreenWidth, height: kSegmentBarHeight)
            self.userDetailView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: userDetailViewHeight)
            self.tableViewOffsetY = CGFloat(0)
            
        } else if (tableViewoffsetY > userDetailViewHeight) {
            
            self.tabBar.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kSegmentBarHeight)
            self.userDetailView.frame = CGRect(x: 0,
                                               y: -userDetailViewHeight,
                                               width: kScreenWidth,
                                               height: userDetailViewHeight)
            self.tableViewOffsetY = userDetailViewHeight
            
        }
    }
}
