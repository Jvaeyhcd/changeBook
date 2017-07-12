//
//  EditAddressViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 12/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class EditAddressViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        intiSubviews()
    }
    
    private func intiSubviews() {
        self.title = "编辑地址"
        self.showBackButton()
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
