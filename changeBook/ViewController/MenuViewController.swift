//
//  MenuViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {
    
    lazy var headbgImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = kMainColor
        return imgView
    }()
    
    lazy var userHeadImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = scaleFromiPhone6Desgin(x: 30)
        imgView.contentMode = .scaleAspectFill
        imgView.isUserInteractionEnabled = true
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 1
        imgView.backgroundColor = kMainBgColor
        return imgView
    }()
    
    lazy var userNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.init(hex: 0xFFFFFF)
        return lbl
    }()
    
    var menuTableView: UITableView = {
        let menuTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        menuTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: kCellIdMenuTableViewCell)
        menuTableView.backgroundColor = UIColor.clear
        menuTableView.separatorStyle = .none
        
        return menuTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MAKR: - private
    private func initSubviews() {
        
        self.view.addSubview(self.headbgImageView)
        self.headbgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 180))
        }
        
        let tapGR = UITapGestureRecognizer.init(target: self, action: #selector(userHeadClick))
        self.userHeadImageView.addGestureRecognizer(tapGR)
        self.headbgImageView.addSubview(self.userHeadImageView)
        self.userHeadImageView.snp.makeConstraints { (make) in
            make.width.equalTo(scaleFromiPhone6Desgin(x: 60))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 60))
            make.left.equalTo(scaleFromiPhone6Desgin(x: 28))
            make.top.equalTo(scaleFromiPhone6Desgin(x: 60))
        }
        
        self.userNameLbl.text = "Jvaeyhcd"
        self.headbgImageView.addSubview(self.userNameLbl)
        self.userNameLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.userHeadImageView.snp.centerY)
            make.left.equalTo(self.userHeadImageView.snp.right).offset(scaleFromiPhone6Desgin(x: 8))
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
        
    }
    
    @objc private func userHeadClick() {
        
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
