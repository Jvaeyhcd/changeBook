//
//  AuthStatusViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 20/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class AuthStatusViewController: BaseViewController {

    var tyep = 1 //1审核中 3审核失败
    
    lazy var topImg = UIImageView()
    lazy var lbText = UILabel()
    lazy var btnReEdit = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = kMainBgColor
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "车主认证"
        self.showBackButton()
        // Do any additional setup after loading the view.
        
        if 1 == self.tyep {
            topImg.image = UIImage(named: "pic_wait")
        }else{
            topImg.image = UIImage(named: "pic_failed")
        }
        
        topImg.contentMode = .scaleAspectFill
        topImg.clipsToBounds = true
        self.view.addSubview(topImg)
        topImg.snp.makeConstraints{
            make -> Void in
            make.top.equalTo(scaleFromiPhone6Desgin(x: 141) + kNavHeight)
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 108))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 100))
        }
        
        if 1 == self.tyep {
            lbText.text = "车主认证审核中，请耐心等待"
        }else{
            lbText.text = "车主认证审核不通过，请重新提交资料"
        }
        
        lbText.textColor = UIColor(hex: 0x888888)
        lbText.font = kBarButtonItemTitleFont
        lbText.numberOfLines = 1
        lbText.textAlignment = .center
        self.view.addSubview(lbText)
        lbText.snp.makeConstraints{
            make -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(topImg.snp.bottom).offset(scaleFromiPhone6Desgin(x: 32))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 22))
        }
        
        btnReEdit.setTitle("再次编辑", for: UIControlState.normal)
        btnReEdit.setTitleColor(kMainColor, for: UIControlState.normal)
        btnReEdit.layer.borderColor = kMainColor?.cgColor
        btnReEdit.layer.borderWidth = 1
        btnReEdit.layer.cornerRadius = 2
        btnReEdit.backgroundColor = UIColor.white
        btnReEdit.titleLabel?.font = kBaseFont
        btnReEdit.addTarget(self, action: #selector(self.clickToReEdit), for: UIControlEvents.touchDown)
        self.view.addSubview(btnReEdit)
        btnReEdit.snp.makeConstraints{
            make -> Void in
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 91))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 33))
            make.top.equalTo(lbText.snp.bottom).offset(scaleFromiPhone6Desgin(x: 29))
        }
        if 1 == self.tyep {
            btnReEdit.isHidden = true
        }else{
            btnReEdit.isHidden = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    func clickToReEdit() {
        let vc = RealnameAuthViewController()
        self.pushViewController(viewContoller: vc, animated: true)
    }

}
