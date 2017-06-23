//
//  RootViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class RootViewController: RESideMenu, RESideMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuPreferredStatusBarStyle = UIStatusBarStyle.lightContent
        self.delegate = self
        self.contentViewShadowColor = UIColor.black
        self.contentViewShadowOffset = CGSize.zero
        self.contentViewShadowOpacity = 0.5
        self.contentViewShadowRadius = 0
        self.contentViewShadowEnabled = true
        self.scaleContentView = false
        self.scaleMenuView = false
        self.scaleBackgroundImageView = false
        self.panGestureEnabled = true
        self.parallaxEnabled = true
        self.contentViewInPortraitOffsetCenterX = kScreenWidth / 3
        
        NotificationCenter.default.addObserver(self, selector: #selector(disableRESideMenu), name: NSNotification.Name.init(rawValue: "disableRESideMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enableRESideMenu), name: NSNotification.Name.init(rawValue: "enableRESideMenu"), object: nil)
        
    }

    func enableRESideMenu() {
        self.panGestureEnabled = true
    }
    
    func disableRESideMenu() {
        self.panGestureEnabled = false
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
    
    // MARK: - RESideMenuDelegate
    func sideMenu(_ sideMenu: RESideMenu!, didRecognizePanGesture recognizer: UIPanGestureRecognizer!) {
        
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, didShowMenuViewController menuViewController: UIViewController!) {
        
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, willHideMenuViewController menuViewController: UIViewController!) {
        
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
        
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, didHideMenuViewController menuViewController: UIViewController!) {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}
