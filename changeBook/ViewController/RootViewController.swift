//
//  RootViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class RootViewController: HcdSideMenu {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(disableRESideMenu), name: NSNotification.Name.init(rawValue: "disableRESideMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enableRESideMenu), name: NSNotification.Name.init(rawValue: "enableRESideMenu"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.panGestureEnabled = true
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}
