//
//  BaseNavigationController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    private var navLineV: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //藏旧
        self.hideBorderInView(view: self.navigationBar)
        //添新
        if nil == navLineV {
            navLineV = UIView.init(frame: CGRect(x: 0, y: 43, width: kScreenWidth, height: 1))
            navLineV.backgroundColor = kMainColor
            self.navigationBar.addSubview(navLineV)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func hideBorderInView(view: UIView) {
        // 隐藏navigationBar的分割线
        if (view is UIImageView && view.frame.size.height <= 1) {
            view.isHidden = true
            view.backgroundColor = kMainBgColor
        }
        
        for subView in view.subviews {
            self.hideBorderInView(view: subView)
        }
    }
    
    override var shouldAutorotate: Bool {
        return (self.visibleViewController?.shouldAutorotate)!
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (self.visibleViewController?.preferredInterfaceOrientationForPresentation)!
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        if !(self.visibleViewController is UIAlertController) {
            return (self.visibleViewController?.supportedInterfaceOrientations)!
        } else {
            return UIInterfaceOrientationMask.portrait
        }
    }
    
}
