//
//  UIViewController+Polesapp.swift
//  changeBook
//
//  Created by Jvaeyhcd on 28/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let LEFT = 1, RIGHT = 2

extension UIViewController {
    
    final func pushViewController(viewContoller: UIViewController, animated:Bool) {
        self.navigationController?.pushViewController(viewContoller, animated: animated)
    }
    
    final func popViewController(animated: Bool) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     添加文字形式的BarButton
     
     - parameter position: 位置LEFT or RIGHT
     - parameter withStr:  文字
     */
    func showBarButtonItem(position:Int, withStr:String) {
        
        let width = withStr.widthWithConstrainedWidth(width: kScreenWidth / 2, font: kBarButtonItemTitleFont)
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: 30))
        btn.titleLabel?.font = kBaseFont
        btn.setTitle(withStr, for: UIControlState.normal)
        btn.setTitleColor(UIColor(hex: 0x232323), for: .normal)
        btn.setTitleColor(UIColor(hex: 0xBDBDBD), for: .disabled)
        let item = UIBarButtonItem(customView: btn)
        if LEFT == position {
            self.navigationItem.leftBarButtonItem = item
            btn.addTarget(self, action: #selector(leftNavBarButtonClicked), for: UIControlEvents.touchUpInside)
        } else if RIGHT == position {
            self.navigationItem.rightBarButtonItem = item
            btn.addTarget(self, action: #selector(rightNavBarButtonClicked), for: UIControlEvents.touchUpInside)
        }
    }
    
    func showSubmitBarButtonItem(position:Int, withStr:String) {
        let width = withStr.widthWithConstrainedWidth(width: kScreenWidth / 2, font: kBarButtonItemTitleFont)
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: 30))
        btn.titleLabel?.font = kBaseFont
        btn.setTitle(withStr, for: UIControlState.normal)
        btn.setTitleColor(UIColor(hex: 0x232323), for: .normal)
        btn.setTitleColor(UIColor(hex: 0xBDBDBD), for: .disabled)
        let item = UIBarButtonItem(customView: btn)
        if LEFT == position {
            self.navigationItem.leftBarButtonItem = item
            btn.addTarget(self, action: #selector(leftNavBarButtonClicked), for: UIControlEvents.touchUpInside)
        } else if RIGHT == position {
            self.navigationItem.rightBarButtonItem = item
            btn.addTarget(self, action: #selector(rightNavBarButtonClicked), for: UIControlEvents.touchUpInside)
        }
    }
    
    func leftNavBarButtonClicked() {
        
    }
    
    func rightNavBarButtonClicked() {
        
    }
    
    /**
     添加图片形式的BarButton
     
     - parameter position:  位置LEFT or RIGHT
     - parameter withImage: 图片
     */
    func showBarButtonItem(position:Int, withImage:UIImage) {
        
        if LEFT == position {
            let item = UIBarButtonItem(image: withImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftNavBarButtonClicked))
            item.tintColor = UIColor.white
            self.navigationItem.leftBarButtonItem = item
        } else if RIGHT == position {
            let item = UIBarButtonItem(image: withImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightNavBarButtonClicked))
            item.tintColor = UIColor.white
            self.navigationItem.rightBarButtonItem = item
        }
    }
    
    func showBackButton() -> Void {
        
        self.showBarButtonItem(position: LEFT, withImage: UIImage(named: "top_btn_back")!)
    }
    
    func showLoginViewController() {
        // 显示登录界面
    }
}
