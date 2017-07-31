//
//  UsersHomeViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 31/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class UsersHomeViewController: BaseViewController {
    
    var user: User!
    
    private lazy var userDetailView: UserDetailView = {
        let view = UserDetailView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: scaleFromiPhone6Desgin(x: 180)))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.showBackButton()
        
        self.view.addSubview(self.userDetailView)
        self.userDetailView.setUser(user: self.user)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
