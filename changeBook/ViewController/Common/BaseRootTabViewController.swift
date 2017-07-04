//
//  BaseRootTabViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 26/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class BaseRootTabViewController: BaseViewController {

    private lazy var userHeadImgView: UIImageView = {
        var imgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        imgView.backgroundColor = kMainBgColor
        imgView.layer.cornerRadius = 18
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGR = UITapGestureRecognizer.init(target: self, action: #selector(userHeadClick))
        self.userHeadImgView.addGestureRecognizer(tapGR)
        let item = UIBarButtonItem.init(customView: self.userHeadImgView)
        item.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = item
        
    }
    
    @objc private func userHeadClick() {
//        self.hcd_sideMenu.showLeftViewController(animated: true)
        self.showLoginViewController()
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
