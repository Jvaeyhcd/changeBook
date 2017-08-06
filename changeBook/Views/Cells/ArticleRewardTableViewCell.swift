//
//  ArticleRewardTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 06/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//  文章数字相关信息cell

import UIKit

let kCellIdArticleRewardTableViewCell = "ArticleRewardTableViewCell"

class ArticleRewardTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var addRewordBlock: (()->())!
    var seeAllBlock: (()->())!
    
    private var rewordLogs = [RewardLog]()
    
    private lazy var rewardBtn: UIButton = {
        let rewardBtn = UIButton()
        rewardBtn.contentMode = .scaleAspectFill
        rewardBtn.imageView?.contentMode = .scaleAspectFill
        rewardBtn.layer.cornerRadius = 4
        rewardBtn.clipsToBounds = true
        rewardBtn.backgroundColor = kMainColor
        rewardBtn.setTitle("积分支持", for: .normal)
        rewardBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return rewardBtn
    }()
    
    private lazy var seeAllBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        btn.titleLabel?.font = kBaseFont
        return btn
    }()
    
    private lazy var likeUsersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(UserHeadCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdUserHeadCollectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRewordLog(logs: [RewardLog]) {
        
        self.rewordLogs = [RewardLog]()
        let number = logs.count
        
        if number > 6 {
            for i in 0..<6 {
                self.rewordLogs.append(logs[number - 1 - i])
            }
        } else {
            for i in 0..<number {
                self.rewordLogs.append(logs[number - 1 - i])
            }
        }
        
        let width = CGFloat(number) * (UserHeadCollectionViewCell.cellSize().width + scaleFromiPhone6Desgin(x: 10)) + scaleFromiPhone6Desgin(x: 10)
        self.likeUsersCollectionView.frame = CGRect(x: (kScreenWidth - width) / 2, y: scaleFromiPhone6Desgin(x: 60) + 3 * kBasePadding, width: width, height: UserHeadCollectionViewCell.cellSize().height)
        self.likeUsersCollectionView.reloadData()
    }
    
    func setRewordNumber(num: Int) {
        
        self.seeAllBtn.setTitle("查看全部\(num)次打赏", for: .normal)
        
    }
    
    fileprivate func initUI() {
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        
        self.rewardBtn.addTarget(self, action: #selector(rewardBtnClicked), for: .touchUpInside)
        self.addSubview(self.rewardBtn)
        self.rewardBtn.snp.makeConstraints { (make) in
            make.top.equalTo(kBasePadding)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 80))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 40))
        }
        
        self.addSubview(self.seeAllBtn)
        self.seeAllBtn.addTarget(self, action: #selector(seeAllBtnClicked), for: .touchUpInside)
        self.seeAllBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.rewardBtn.snp.bottom).offset(kBasePadding)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.likeUsersCollectionView)
        
    }
    
    @objc private func rewardBtnClicked() {
        if nil != self.addRewordBlock {
            self.addRewordBlock()
        }
    }
    
    @objc private func seeAllBtnClicked() {
        if nil != self.seeAllBlock {
            self.seeAllBlock()
        }
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 60) + 4 * kBasePadding + UserHeadCollectionViewCell.cellSize().height
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rewordLogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdUserHeadCollectionViewCell, for: indexPath) as! UserHeadCollectionViewCell
        
        let rewordLog = self.rewordLogs[indexPath.row]
        
        cell.headImgView.sd_setImage(with: URL.init(string: rewordLog.user.headPic), placeholderImage: kNoImgDefaultImage)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    // 设置cell和视图边的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(scaleFromiPhone6Desgin(x: 0), scaleFromiPhone6Desgin(x: 10), scaleFromiPhone6Desgin(x: 0), scaleFromiPhone6Desgin(x: 10))
    }
    
    // 设置每一个cell最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return scaleFromiPhone6Desgin(x: 10)
    }
    
    // 设置每一个cell的列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return scaleFromiPhone6Desgin(x: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return UserHeadCollectionViewCell.cellSize()
        
    }
    
}

let kCellIdUserHeadCollectionViewCell = "UserHeadCollectionViewCell"

class UserHeadCollectionViewCell: UICollectionViewCell {
    
    lazy var headImgView: UIImageView = {
        let headImgView = UIImageView()
        headImgView.contentMode = .scaleAspectFill
        headImgView.backgroundColor = kMainBgColor
        headImgView.layer.cornerRadius = scaleFromiPhone6Desgin(x: 15)
        headImgView.clipsToBounds = true
        return headImgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.headImgView)
        self.headImgView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func cellSize() -> CGSize {
        return CGSize(width: scaleFromiPhone6Desgin(x: 30), height: scaleFromiPhone6Desgin(x: 30))
    }
}
