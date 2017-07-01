//
//  TeacherHomeViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 23/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class TeacherHomeViewController: BaseRootTabViewController, HcdTabBarDelegate {

    private var cates = ["推荐", "理工", "社科", "教辅", "课外"];
    private var selectedControllerIndex = -1
    private var viewControllers = [TeacherListViewController]()
    lazy var tabBar: SlippedSegmentView = {
        
        let tabBar = SlippedSegmentView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kNavHeight))
        tabBar.backgroundColor = UIColor.white
        tabBar.showSelectedBgView(show: false)
        return tabBar
        
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    private var contentViewFrame: CGRect?
    private var contentSwitchAnimated = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "教师"
        self.showBarButtonItem(position: RIGHT, withImage: UIImage(named: "jieshu_btn_sousuo")!)
        NotificationCenter.default.post(name: NSNotification.Name.init("enableRESideMenu"), object: nil)
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.clipsToBounds = true
        
        self.tabBar.delegate = self
        self.view.addSubview(self.tabBar)
        
        setupFrameOfTabBarAndContentView()
        
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
        
        setTabBarFrame(tabBarFrame: CGRect.init(x: 0, y: kNavHeight, width: kScreenWidth, height: kSegmentBarHeight),
                       contentViewFrame: CGRect.init(x: 0, y: kSegmentBarHeight + kNavHeight, width: kScreenWidth, height: kScreenHeight - kNavHeight - kSegmentBarHeight))
        
        updateViewControllers()
    }

    private func updateContentViewsFrame() {
        self.scrollView.frame = self.contentViewFrame!
        
        self.scrollView.contentSize = CGSize.init(width: self.contentViewFrame!.size.width * CGFloat(self.viewControllers.count), height: self.contentViewFrame!.size.height)
        
        var index = 0
        
        self.viewControllers.forEach{ controller in
            
            if controller.isViewLoaded {
                
                controller.view.frame = CGRect.init(x: CGFloat(index) * self.contentViewFrame!.size.width, y: 0, width: self.contentViewFrame!.size.width, height: self.contentViewFrame!.size.height)
            }
            
            index = index + 1
        }
        
        if nil != selectedController() {
            self.scrollView.scrollRectToVisible(selectedController()!.view.frame, animated: false)
        }
    }
    
    // 更新ViewControllers
    private func updateViewControllers() {
        
        
        if self.viewControllers.count > 0 {
            self.viewControllers.removeAll()
        }
        
        for cate in self.cates {
            
            let vc = TeacherListViewController()
            vc.parentVC = self
            vc.title = cate
            viewControllers.append(vc)
            
        }
        
        self.setViewControllers(viewControllers: self.viewControllers)
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
        
        let tabBarHeight = CGFloat(64)
        
        let contentViewY = tabBarHeight
        let tabBarY = CGFloat(0)
        var contentViewHeight = screenSize.height - tabBarHeight
        
        // 如果parentViewController为UINavigationController及其子类
        
        if nil != self.parent && (self.parent?.isKind(of: UINavigationController.self))! && nil != self.navigationController && !self.navigationController!.isNavigationBarHidden && !self.navigationController!.navigationBar.isHidden {
            let navMaxY = self.navigationController!.navigationBar.frame.maxY
            if !self.navigationController!.navigationBar.isTranslucent || self.edgesForExtendedLayout == .none || self.edgesForExtendedLayout == .top {
                contentViewHeight = screenSize.height - tabBarHeight - navMaxY
            } else {
                
            }
        }
        
        self.setTabBarFrame(tabBarFrame: CGRect.init(x: 0, y: tabBarY, width: screenSize.width, height: tabBarHeight), contentViewFrame: CGRect.init(x: 0, y: contentViewY, width: screenSize.width, height: contentViewHeight))
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
        let curController = self.viewControllers[selectedControllerIndex]
        var isAppearFirstTime = true
        
        oldController?.viewWillDisappear(false)
        if nil == curController.view.superview {
            // superview为空，表示为第一次加载，设置frame，并添加到scrollView
            curController.view.frame = CGRect.init(x: CGFloat(selectedControllerIndex) * self.scrollView.frame.size.width, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
            self.scrollView.addSubview(curController.view)
        } else {
            // superview不为空，表示为已经加载过了，调用viewWillAppear方法
            isAppearFirstTime = false
            curController.viewWillAppear(false)
        }
        // 切换到curController
        self.scrollView.scrollRectToVisible(curController.view.frame, animated: self.contentSwitchAnimated)
        
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
    func setViewControllers(viewControllers: [TeacherListViewController]) {
        
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
        self.scrollView.contentSize = CGSize.init(width: self.contentViewFrame!.size.width, height: self.contentViewFrame!.size.height)
        
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
        self.scrollView.isScrollEnabled = true
        
        self.setSelectedControllerIndex(selectedControllerIndex: didSelectedItemAtIndex)
    }
    
    func tabBar(tabBar: SlippedSegmentView, willSelectItemAtIndex: Int) -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
