//
//  HomeHeadView.swift
//  changeBook
//
//  Created by Jvaeyhcd on 29/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class HomeHeadView: UIView, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let titles = ["书籍", "资料", "捐赠", "打印"]
    let icons = ["home_btn_jieshu", "home_btn_ziliao", "home_btn_juanzeng-", "home_btn_dayin"]
    var selectCollectionIndex: ((Int)->())?

    lazy var cycleScrollView: SDCycleScrollView = {
        let cycleView = SDCycleScrollView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth * 150.0 / 375.0))
        return cycleView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: kScreenWidth * 150.0 / 375.0, width: kScreenWidth, height: kScreenWidth / 4 + scaleFromiPhone6Desgin(x: 30)), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(NormalCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdNormalCollectionViewCell)
        return collectionView
    }()
    
    lazy var lineView: UIView = {
    
        let view = UIView()
        view.backgroundColor = kMainBgColor
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.cycleScrollView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.addSubview(self.collectionView)
        
        self.lineView.frame = CGRect(x: 0, y: self.collectionView.frame.maxY, width: kScreenWidth, height: kBasePadding)
        self.addSubview(self.lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdNormalCollectionViewCell, for: indexPath) as! NormalCollectionViewCell
        
        let title = titles[indexPath.row]
        let icon = icons[indexPath.row]
        cell.titleLbl.text = title
        cell.iconImage.image = UIImage(named: icon)
        
        return cell
    }
    
    //设置指定cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (kScreenWidth - 3) / 4.0, height: kScreenWidth  / 4.0 + scaleFromiPhone6Desgin(x: 30))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //每行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if nil != self.selectCollectionIndex {
            self.selectCollectionIndex?(indexPath.row)
        }
    }

}
