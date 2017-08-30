//
//  DepositViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 20/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class DepositViewController: BaseViewController {
    
    private lazy var bgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = UIViewContentMode.scaleAspectFill
        imgView.image = UIImage.init(named: "yajin_bg")
        return imgView
    }()
    
    private var payBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = kBarButtonItemTitleFont
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = kMainColor
        btn.setTitle("押金退款", for: .normal)
        return btn
    }()
    
    private lazy var tipsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "已缴纳押金（元）"
        lbl.textColor = UIColor(hex: 0x888888)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    private lazy var moneyLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "30"
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 24)
        return lbl
    }()
    
    private lazy var bookLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "（可借书3本）"
        lbl.textColor = UIColor(hex: 0x888888)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    
    private func initSubviews() {
        self.title = "我的押金"
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withStr: "押金明细")
        
        self.view.addSubview(self.bgView)
        self.bgView.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(kDepositTableViewHeight)
        }
        
        self.view.addSubview(self.payBtn)
        self.payBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.bgView.snp.bottom).offset(kBasePadding)
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
        }
        
        self.view.addSubview(self.tipsLbl)
        self.tipsLbl.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.centerY.equalTo(self.bgView.snp.centerY).offset(scaleFromiPhone6Desgin(x: -scaleFromiPhone6Desgin(x: 80)))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.view.addSubview(self.moneyLbl)
        self.moneyLbl.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(self.tipsLbl.snp.bottom).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
        }
        
        self.view.addSubview(self.bookLbl)
        self.bookLbl.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(self.moneyLbl.snp.bottom).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        let vc = DepositDetailViewController()
        self.pushViewController(viewContoller: vc, animated: true)
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
