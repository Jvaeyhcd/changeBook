//
//  RealnameAuthViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 05/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class RealnameAuthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ImagePickerDelegate {

    let uploadManager = QiniuManager()
    var imagePicker = ImagePickerController()
    private var viewModel = UserViewModel()
    
    fileprivate var userName = ""
    fileprivate var number = ""
    fileprivate var images = [UIImage]()
    let tips = "请上传一卡通或学生证，照片中应该包含：学生的姓名、学号、学院和学校"
    
    lazy var tableView : UITableView = {
       let contentTableView = TPKeyboardAvoidingTableView.init()
        contentTableView.register(SimpleInputTableViewCell.self, forCellReuseIdentifier: kCellIdSimpleInputTableViewCell)
        contentTableView.register(SelectPhotoTableViewCell.self, forCellReuseIdentifier: kCellIdSelectPhotoTableViewCell)
        contentTableView.register(SignleImageTableViewCell.self, forCellReuseIdentifier: kCellIdSignleImageTableViewCell)
        contentTableView.register(TipsTableViewCell.self, forCellReuseIdentifier: kCellIdTipsTableViewCell)
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.separatorStyle = .none
        contentTableView.backgroundColor = kMainBgColor
        return contentTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "学生实名认证"
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withStr: "提交")
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if 0 == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSimpleInputTableViewCell, for: indexPath) as! SimpleInputTableViewCell
            
            if 0 == indexPath.row {
                cell.lbName.text = "姓名"
                cell.tfName.text = self.userName
                cell.tfName.placeholder = "请输入您的真实姓名"
                cell.textChangedBlock = {
                    [weak self] (str) in
                    self?.userName = str
                }
            } else if 1 == indexPath.row {
                cell.lbName.text = "学号"
                cell.tfName.text = self.number
                cell.tfName.placeholder = "亲输入您的学号"
                cell.textChangedBlock = {
                    [weak self] (str) in
                    self?.number = str
                }
            }
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            
            return cell
        } else if 1 == indexPath.section {
            
            if 0 == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSelectPhotoTableViewCell, for: indexPath) as! SelectPhotoTableViewCell
                cell.assets = self.imagePicker.stack.assets
                cell.images = self.images
                cell.limitLength = 1
                cell.addPicturesBlock = {
                    self.imagePicker.delegate = self
                    self.imagePicker.imageLimit = 1
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
                cell.deleteImageAssetBlock = {
                    
                    [weak self] (image, asset) in
                    
                    var index = 0
                    for img in (self?.images)! {
                        if img == image {
                            break
                        }
                        index = index + 1
                    }
                    
                    for imageAsset in (self?.imagePicker.stack.assets)! {
                        if imageAsset == asset {
                            self?.imagePicker.stack.dropAsset(asset)
                            break
                        }
                    }
                    
                    self?.images.remove(at: index)
                    self!.tableView.reloadData()
                    
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdTipsTableViewCell, for: indexPath) as! TipsTableViewCell
                
                cell.textLabel?.text = self.tips
                return cell
            }
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSignleImageTableViewCell, for: indexPath) as! SignleImageTableViewCell
            cell.imgView.image = UIImage(named: "vertify_img")
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height = CGFloat(0)
        
        if 0 == indexPath.section {
            height = SimpleInputTableViewCell.cellHeight()
        } else if 1 == indexPath.section {
            if 0 == indexPath.row {
                height = SelectPhotoTableViewCell.cellHeight(datas: self.images)
            } else {
                height = TipsTableViewCell.cellHeightWithStr(str: self.tips)
            }
            
        } else if 2 == indexPath.section {
            height = SignleImageTableViewCell.cellHeight()
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height = kBasePadding
        
        if 1 == section || 2 == section {
            height = scaleFromiPhone6Desgin(x: 50) + kBasePadding
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if 1 == section || 2 == section {
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBasePadding + scaleFromiPhone6Desgin(x: 50)))
            
            let topView = UIView()
            topView.backgroundColor = kMainBgColor
            view.addSubview(topView)
            topView.snp.makeConstraints({ (make) in
                make.top.equalTo(0)
                make.right.equalTo(0)
                make.left.equalTo(0)
                make.height.equalTo(kBasePadding)
            })
            
            let tipsLbl = UILabel()
            tipsLbl.font = UIFont.systemFont(ofSize: 16)
            tipsLbl.textColor = UIColor(hex: 0x555555)
            tipsLbl.textAlignment = .left
            if 1 == section {
                tipsLbl.text = "学生证/一卡通照片"
            } else if 2 == section {
                tipsLbl.text = "申请模板"
            }
            
            view.addSubview(tipsLbl)
            tipsLbl.snp.makeConstraints({ (make) in
                make.top.equalTo(topView.snp.bottom)
                make.right.equalTo(-kBasePadding)
                make.left.equalTo(kBasePadding)
                make.bottom.equalTo(0)
            })
            
            view.backgroundColor = UIColor.white
            return view
        } else if 0 == section {
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBasePadding))
            view.backgroundColor = kMainBgColor
            return view
        }
        return nil
    }
    
    // MARK: - ImagePickerDelegate
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.images = [UIImage]()
        for img in images{
            self.images.append(img.wxCompress())
        }
        self.tableView.reloadData()
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        if self.userName.isEmpty {
            self.showHudTipStr("请输入您的姓名")
        } else if self.number.isEmpty {
            self.showHudTipStr("请输入您的学号")
        } else if self.images.count == 0 {
            self.showHudTipStr("请上传您的学生证或者一卡通照片")
        } else if self.images.count > 0 {
            self.uploadPicture()
        }
    }
    
    //上传图片
    private func uploadPicture() {
        self.view.endEditing(true)
        self.showHudLoadingTipStr("")
        
        uploadManager.images = [UIImage.fixOrientation(images[0])]
        uploadManager.type = "u"
        uploadManager.uploadImages(successBlock: { [weak self] (picList) in
            BLog(log: "picList：\(picList)")
            let arry = (picList as NSString).components(separatedBy: ",")
            
            if arry.count > 0 {
                self?.addUserCertification(pic: arry[0])
            } else {
                self?.showHudTipStr("图片上传失败")
            }
            
        }) { [weak self] (message) in
            self!.showHudTipStr(message)
        }
        
    }
    
    //申请学生认证
    private func addUserCertification(pic: String) {
        self.viewModel.addUserCertification(userName: self.userName, studentNo: self.number, pic: pic, success: { [weak self] (data) in
            self?.showHudTipStr("提交成功！请耐心等待~")
            self?.popViewController(animated: true)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
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
