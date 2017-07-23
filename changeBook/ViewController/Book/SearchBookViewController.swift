//
//  SearchBookViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 23/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class SearchBookViewController: BaseViewController {
    
    fileprivate var searchBar: UISearchBar = {
        
        let search = UISearchBar()
        
        search.layer.cornerRadius = 4
        search.clipsToBounds = true
//        search.backgroundImage = UIImage.init(color: UIColor(hex: 0xF4F4F4))
//        search.scopeBarBackgroundImage = UIImage.init(color: UIColor(hex: 0xF4F4F4))
//        search.barTintColor = UIColor(hex: 0xF4F4F4)
        search.placeholder = "请输入搜索内容"
        
//        search.setSearchFieldBackgroundImage(UIImage.init(color: UIColor.init(hex: 0xF4F4F4)!,
//                                                          size: CGSize(width: kScreenWidth - 100, height: 30)), for: .normal)
        return search
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        
        self.showBackButton()
        
        let titleView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 70, height: 40))
        titleView.backgroundColor = UIColor.white
        titleView.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.height.equalTo(30)
            make.right.equalTo(0)
            make.top.equalTo(5)
        }
        
        self.navigationItem.titleView = titleView
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
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
