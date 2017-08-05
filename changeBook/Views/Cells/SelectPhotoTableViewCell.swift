//
//  SelectPhotoTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 05/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import Photos

let kCellIdSelectPhotoTableViewCell = "SelectPhotoTableViewCell"

class SelectPhotoTableViewCell: UITableViewCell {

    var limitLength = 8
    
    var addPicturesBlock: (() -> ())!
    var deleteImageAssetBlock: ((UIImage, PHAsset) -> ())!
    
    var images: [UIImage]? {
        willSet {
            
        }
        didSet {
            mediaView?.frame = CGRect.init(x: scaleFromiPhone6Desgin(x: 16), y: scaleFromiPhone6Desgin(x: 16), width: kScreenWidth - scaleFromiPhone6Desgin(x: 32), height: SelectPhotoTableViewCell.cellHeight(datas: images!))
            mediaView?.reloadData()
        }
    }
    
    var assets: [PHAsset]!
    
    fileprivate var mediaView: UICollectionView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        initSubviews()
    }
    
    func initSubviews() {
        
        if nil == images {
            images = [UIImage]()
        }
        
        if nil == mediaView {
            let layout = UICollectionViewFlowLayout()
            //            layout.itemSize = TweetSendImageCCell.ccellSize()
            
            self.mediaView = UICollectionView.init(frame: CGRect.init(x: scaleFromiPhone6Desgin(x: 16), y: scaleFromiPhone6Desgin(x: 16), width: kScreenWidth - scaleFromiPhone6Desgin(x: 32), height: (kScreenWidth - scaleFromiPhone6Desgin(x: 32) - scaleFromiPhone6Desgin(x: 30)) / 4), collectionViewLayout: layout)
            mediaView?.isScrollEnabled = true
            mediaView?.allowsSelection = true
            mediaView?.isUserInteractionEnabled = true
            mediaView?.register(SelectPhotoTableViewCCell.self, forCellWithReuseIdentifier: kCellIdSelectPhotoTableViewCCell)
            mediaView?.dataSource = self
            mediaView?.delegate = self
            mediaView?.backgroundColor = UIColor.white
            self.contentView.addSubview(mediaView!)
            mediaView?.snp.makeConstraints{
                make -> Void in
                make.left.equalTo(kBasePadding)
                make.top.equalTo(scaleFromiPhone6Desgin(x: 16))
                make.bottom.equalTo(-scaleFromiPhone6Desgin(x: 16))
                make.right.equalTo(-kBasePadding)
            }
        }
    }
    //MAKR: - static
    static func cellHeight(datas: [UIImage]) -> CGFloat {
        if 4 <= datas.count{
            return (((kScreenWidth - scaleFromiPhone6Desgin(x: 32) - scaleFromiPhone6Desgin(x: 30)) / 4) * 2 + scaleFromiPhone6Desgin(x: 32) + scaleFromiPhone6Desgin(x: 12))
        }else{
            return (((kScreenWidth - scaleFromiPhone6Desgin(x: 32) - scaleFromiPhone6Desgin(x: 30)) / 4) + scaleFromiPhone6Desgin(x: 32))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

extension SelectPhotoTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = images?.count
        if limitLength == count{
            return limitLength
        }else{
            return count! < limitLength ? count! + 1 : count!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ccell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdSelectPhotoTableViewCCell, for: indexPath as IndexPath) as! SelectPhotoTableViewCCell
        
        if indexPath.row < (images?.count)! {
            ccell.currentImage = images![indexPath.row]
            ccell.deleteTweetImageBlock = {
                [weak self] currentImage in
                if nil != self!.deleteImageAssetBlock {
                    self!.deleteImageAssetBlock(currentImage, (self?.assets[indexPath.row])!)
                }
            }
        } else {
            ccell.currentImage = nil
        }
        
        return ccell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == images!.count {
            if self.addPicturesBlock != nil {
                self.addPicturesBlock()
            }
        }
    }
    
    // MARK:- UICollectionViewDelegateFlowLayout
    // 设置cell和视图边的间距
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsetsZero
    //    }
    
    // 设置每一个cell最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return scaleFromiPhone6Desgin(x: 10)
    }
    
    // 设置每一个cell的列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return scaleFromiPhone6Desgin(x: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize.init(width: (kScreenWidth - scaleFromiPhone6Desgin(x: 32) - scaleFromiPhone6Desgin(x: 30)) / 4, height: (kScreenWidth - scaleFromiPhone6Desgin(x: 32) - scaleFromiPhone6Desgin(x: 30)) / 4)
        
    }
    
}

let kCellIdSelectPhotoTableViewCCell = "SelectPhotoTableViewCCell"
let kSelectPhotoTableViewCCellWidth = (kScreenWidth - 60) / 4

class SelectPhotoTableViewCCell: UICollectionViewCell {
    typealias deleteBlock = (UIImage) -> ()
    
    var deleteTweetImageBlock: deleteBlock!
    
    var currentImage: UIImage? {
        willSet {
            
        }
        didSet {
            if nil != currentImage {
                deleteBtn?.isHidden = false
                imgView!.image = currentImage
            } else {
                deleteBtn?.isHidden = true
                imgView!.image = UIImage(named: "addPictureBgImage")
            }
        }
    }
    
    
    private var imgView: UIImageView?
    private var deleteBtn: UIButton?
    
    static func ccellSize() -> CGSize {
        return CGSize.init(width: kSelectPhotoTableViewCCellWidth, height: kSelectPhotoTableViewCCellWidth)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    // MARK: - private
    
    func initSubviews() {
        if nil == imgView {
            imgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kSelectPhotoTableViewCCellWidth, height: kSelectPhotoTableViewCCellWidth))
            imgView?.contentMode = .scaleAspectFill
            imgView?.clipsToBounds = true
            imgView?.layer.masksToBounds = true
            imgView?.layer.cornerRadius = 2.0
            imgView?.backgroundColor = UIColor.white
            self.contentView.addSubview(imgView!)
            imgView?.snp.makeConstraints{
                make -> Void in
                make.left.right.equalTo(0)
                make.top.bottom.equalTo(0)
            }
        }
        
        if nil == deleteBtn {
            deleteBtn = UIButton.init(frame: CGRect.init(x: kSelectPhotoTableViewCCellWidth - 20, y: 0, width: 20, height: 20))
            deleteBtn?.tintColor = UIColor.red
            deleteBtn?.setImage(UIImage(named: "btn_delete_tweetimage"), for: .normal)
            deleteBtn?.backgroundColor = UIColor.clear
            deleteBtn?.layer.masksToBounds = true
            deleteBtn?.addTarget(self, action: #selector(deleteBtnClicked(btn:)), for: .touchUpInside)
            self.contentView.addSubview(deleteBtn!)
            deleteBtn?.snp.makeConstraints{
                make -> Void in
                make.top.right.equalTo(0)
                make.width.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            }
        }
    }
    
    func deleteBtnClicked(btn:UIButton) {
        if self.deleteTweetImageBlock != nil {
            self.deleteTweetImageBlock(self.currentImage!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
