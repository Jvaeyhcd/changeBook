//
//  SelectSendTimeViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 27/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class SelectSendTimeViewController: BaseViewController {
    
    private lazy var dateTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private lazy var timeTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubveiws()
    }
    
    private func initSubveiws() {
        
        self.view.backgroundColor = UIColor.white
        
        self.title = "送货时间"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18),NSForegroundColorAttributeName: UIColor.white]
        
        self.contentSizeInPopup = CGSize(width: kScreenWidth, height: SelectPayWayTableViewCell.cellHeight() * 2 + scaleFromiPhone6Desgin(x: 50) + 3 * kBasePadding)
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
