//
//  AddressListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 07/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class AddressListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }

    private func initSubviews() {
        self.title = "收货地址"
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
