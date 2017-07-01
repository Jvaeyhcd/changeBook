//
//  HomeViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 23/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class HomeViewController: BaseRootTabViewController {
    
    lazy var headView: HomeHeadView = {
        let headView = HomeHeadView.init(frame: CGRect(x: 0, y: kNavHeight, width: kScreenWidth, height: kScreenWidth * (150.0 / 375.0 + 0.25) + scaleFromiPhone6Desgin(x: 30)))
        return headView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "首页"
        self.view.addSubview(self.headView)
        self.showBarButtonItem(position: RIGHT, withImage: UIImage(named: "home_btn_shubao")!)
        self.headView.selectCollectionIndex = {
            [weak self] (index) in
            switch index {
            case 0:
                let vc = BorrowBookViewController()
                vc.hidesBottomBarWhenPushed = true
                self?.pushViewController(viewContoller: vc, animated: true)
                break
            case 1:
                let vc = DataViewController()
                vc.hidesBottomBarWhenPushed = true
                self?.pushViewController(viewContoller: vc, animated: true)
                break
            case 2:
                
                break
            case 3:
                
                break
            default:
                break
            }
        }
        self.automaticallyAdjustsScrollViewInsets = false
        
        NotificationCenter.default.post(name: NSNotification.Name.init("enableRESideMenu"), object: nil)
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
