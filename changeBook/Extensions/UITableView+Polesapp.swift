//
//  UITableView+Polesapp.swift
//  qiangtoubao
//
//  Created by polesapp-hcd on 16/7/18.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

import UIKit

private var TABLEVIEW_HEADER_PROPERTY = 0
private var TABLEVIEW_FOOTER_PROPERTY = 1

// 封装带有分页的tableView
class UIRefreshTableView: TPKeyboardAvoidingTableView, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var headerRefreshBlock: VoidBlock?
    var footerRefreshBlock: VoidBlock?
    var reloadBlock: VoidBlock?
    
    private var verticalOffsetForEmptyDataSet = CGFloat(0)
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.footerRefresh()
        self.headerRefresh()
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置下拉刷新动画
    func setPullingHeader() {
        let header = MJRefreshGifHeader()
        header.stateLabel.isHidden = true
        header.lastUpdatedTimeLabel.isHidden = true
        header.setImages([UIImage(named: "refresh00")!, UIImage(named: "refresh01")!, UIImage(named: "refresh02")!, UIImage(named: "refresh03")!, UIImage(named: "refresh04")!, UIImage(named: "refresh05")!, UIImage(named: "refresh06")!, UIImage(named: "refresh07")!, UIImage(named: "refresh08")!, UIImage(named: "refresh09")!, UIImage(named: "refresh10")!], for: .pulling)
        header.setImages([UIImage(named: "refresh00")!, UIImage(named: "refresh01")!, UIImage(named: "refresh02")!, UIImage(named: "refresh03")!, UIImage(named: "refresh04")!, UIImage(named: "refresh05")!, UIImage(named: "refresh06")!, UIImage(named: "refresh07")!, UIImage(named: "refresh08")!, UIImage(named: "refresh09")!, UIImage(named: "refresh10")!], for: .refreshing)
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.mj_header = header
    }
    
    // 设置上拉加载跟多动画
    func setPullingFooter() {
        // 底部刷新
        let footer = MJRefreshAutoNormalFooter()
        footer.setTitle("加载更多", for: MJRefreshState.idle)
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        footer.isAutomaticallyHidden = true
        self.mj_footer = footer
    }
    
    @objc private func headerRefresh() {
        if nil != self.headerRefreshBlock {
            self.headerRefreshBlock!()
        }
    }
    
    @objc private func footerRefresh() {
        if nil != self.footerRefreshBlock {
            self.footerRefreshBlock!()
        }
    }
    
    // MARK: - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
        if (nil != self.mj_footer) {
            self.mj_footer.isHidden = true
        }
        if nil != self.mj_header {
            self.mj_header.isHidden = true
        }
    
    }
    
    func emptyDataSetWillDisappear(_ scrollView: UIScrollView!) {
        if (nil != self.mj_footer) {
            self.mj_footer.isHidden = false
        }
        if nil != self.mj_header {
            self.mj_header.isHidden = false
        }
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return self.verticalOffsetForEmptyDataSet
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let networkWorked = kUserDefaults.bool(forKey: "networkWorked")
        if networkWorked{
            //有网
            return UIImage(named: "pic_null")
        }else{
            //无网
            return UIImage(named: "pic_network_null")
        }
        
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var text = ""
        
        let networkWorked = kUserDefaults.bool(forKey: "networkWorked")
        if networkWorked{
            //有网
            text = "暂时没有相关内容"
        }else{
            //无网
            text = "无网络连接，点击页面重试"
        }
        
        return NSAttributedString.init(string: text, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor(hex: 0xBBD4F3)!])
        
        
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        let networkWorked = kUserDefaults.bool(forKey: "networkWorked")
        if networkWorked{
            //有网
            return false
        }else{
            //无网
            return true
        }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        BLog(log: "点击了界面")
        if nil != self.reloadBlock {
            self.reloadBlock!()
        }
    }
    
    func setEmptyDataSetVerticalOffset(offset: CGFloat) {
        self.verticalOffsetForEmptyDataSet = offset
        self.reloadData()
    }
    
}

extension UITableView {
    
    func addLineforPlainCell(cell:UITableViewCell, indexPath:IndexPath, leftSpace:CGFloat) {
        self.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: leftSpace, hasSectionTopLine: false, hasSectionBottomLine: true)
    }
    
    func addLineforPlainCell(cell:UITableViewCell, indexPath:IndexPath, leftSpace:CGFloat, hasSectionTopLine:Bool, hasSectionBottomLine:Bool) {
        let layer = CAShapeLayer.init()
        let pathRef = CGMutablePath()
        
        //适配比5s更大尺寸的屏幕
        cell.bounds = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: kScreenWidth, height: cell.bounds.size.height)
        let bounds = cell.bounds.insetBy(dx: 0, dy: 0)
        
        pathRef.addRect(bounds)
//        CGPathAddRect(pathRef, nil, bounds)
        
        
        layer.path = pathRef
        
        if cell.backgroundColor != nil {
            layer.fillColor = cell.backgroundColor!.cgColor;//layer的填充色用cell原本的颜色
        } else if cell.backgroundView != nil && cell.backgroundView!.backgroundColor != nil {
            layer.fillColor = cell.backgroundView!.backgroundColor!.cgColor;
        } else {
            layer.fillColor = UIColor.init(white: 1.0, alpha: 0.8).cgColor;
        }
        
        let lineColor = kSplitLineBgColor!.cgColor
        let sectionLineColor = lineColor
        
        if indexPath.row == 0 && indexPath.row == self.numberOfRows(inSection: indexPath.section) - 1 {
            //只有一个cell。加上长线&下长线
            if hasSectionTopLine {
                self.layer(layer: layer, addLineUp: true, isLong: true, color: sectionLineColor, bounds: bounds, leftSpace: 0)
            }
            if hasSectionBottomLine {
                self.layer(layer: layer, addLineUp: false, isLong: true, color: sectionLineColor, bounds: bounds, leftSpace: 0)
            }
        } else if indexPath.row == 0 {
            //第一个cell。加上长线&下短线
            if hasSectionTopLine {
                self.layer(layer: layer, addLineUp: true, isLong: true, color: sectionLineColor, bounds: bounds, leftSpace: 0)
            }
            self.layer(layer: layer, addLineUp: false, isLong: false, color: lineColor, bounds: bounds, leftSpace: leftSpace)
            
        } else if indexPath.row == self.numberOfRows(inSection: indexPath.section) - 1 {
            //最后一个cell。加下长线
            if hasSectionBottomLine {
                self.layer(layer: layer, addLineUp: false, isLong: true, color: sectionLineColor, bounds: bounds, leftSpace: 0)
            }
        } else {
            //中间的cell。只加下短线
            self.layer(layer: layer, addLineUp: false, isLong: false, color: lineColor, bounds: bounds, leftSpace: leftSpace)
        }
        
        let bgView = UIView.init(frame: bounds)
        bgView.layer.insertSublayer(layer, at: 0)
        cell.backgroundView = bgView
    }
    
    private func layer(layer:CALayer, addLineUp:Bool, isLong:Bool, color:CGColor, bounds:CGRect, leftSpace:CGFloat) {
        let lineLayer = CALayer.init()
        let lineHeight = (1.0 / UIScreen.main.scale)
        var left, top: CGFloat
        
        if addLineUp == true {
            top = 0
        } else {
            top = bounds.size.height-lineHeight
        }
        
        if isLong {
            left = 0
        } else {
            left = leftSpace
        }
        
//        lineLayer.frame = CGRectMake(bounds.minX+left, top, bounds.size.width-left, lineHeight);
        lineLayer.frame = CGRect(x: bounds.minX+left, y: top, width: bounds.size.width-left, height: lineHeight)
        lineLayer.backgroundColor = color;
        layer.addSublayer(lineLayer);
    }
    
    //左右都加space
    
    func addLineLeftAndRightSpaceForPlainCell(cell:UITableViewCell, indexPath:IndexPath, leftSpace:CGFloat, rightSpace:CGFloat) {
        self.addLineLeftAndRight(cell: cell, indexPath: indexPath, leftSpace: leftSpace, rightSpace: rightSpace, hasSectionTopLine: false, hasSectionBottomLine: true)
    }
    
    func addLineLeftAndRight(cell:UITableViewCell, indexPath:IndexPath, leftSpace:CGFloat, rightSpace:CGFloat, hasSectionTopLine:Bool, hasSectionBottomLine:Bool) {
        let layer = CAShapeLayer.init()
        let pathRef = CGMutablePath()
        
        //适配比5s更大尺寸的屏幕
        cell.bounds = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: kScreenWidth, height: cell.bounds.size.height)
        let bounds = cell.bounds.insetBy(dx: 0, dy: 0)
        
        pathRef.addRect(bounds)
        //        CGPathAddRect(pathRef, nil, bounds)
        
        
        layer.path = pathRef
        
        if cell.backgroundColor != nil {
            layer.fillColor = cell.backgroundColor!.cgColor;//layer的填充色用cell原本的颜色
        } else if cell.backgroundView != nil && cell.backgroundView!.backgroundColor != nil {
            layer.fillColor = cell.backgroundView!.backgroundColor!.cgColor;
        } else {
            layer.fillColor = UIColor.init(white: 1.0, alpha: 0.8).cgColor;
        }
        
        let lineColor = kSplitLineBgColor!.cgColor
        let sectionLineColor = lineColor
        
        if indexPath.row == 0 && indexPath.row == self.numberOfRows(inSection: indexPath.section) - 1 {
            //只有一个cell。加上长线&下长线
            if hasSectionTopLine {
                self.layerLeftAndRight(layer: layer, addLineUp: true, isLong: true, color: sectionLineColor, bounds: bounds, leftSpace: 0, rightSpace: 0)
            }
            if hasSectionBottomLine {
                self.layerLeftAndRight(layer: layer, addLineUp: false, isLong: true, color: sectionLineColor, bounds: bounds, leftSpace: 0, rightSpace: 0)
            }
        } else if indexPath.row == 0 {
            //第一个cell。加上长线&下短线
            if hasSectionTopLine {
                self.layerLeftAndRight(layer: layer, addLineUp: true, isLong: true, color: sectionLineColor, bounds: bounds, leftSpace: 0, rightSpace: 0)
            }
            self.layerLeftAndRight(layer: layer, addLineUp: false, isLong: false, color: sectionLineColor, bounds: bounds, leftSpace: leftSpace, rightSpace: rightSpace)
            
        } else if indexPath.row == self.numberOfRows(inSection: indexPath.section) - 1 {
            //最后一个cell。加下长线
            if hasSectionBottomLine {
                self.layerLeftAndRight(layer: layer, addLineUp: false, isLong: true, color: sectionLineColor, bounds: bounds, leftSpace: 0, rightSpace: 0)
            }
        } else {
            //中间的cell。只加下短线
            self.layerLeftAndRight(layer: layer, addLineUp: false, isLong: false, color: sectionLineColor, bounds: bounds, leftSpace: leftSpace, rightSpace: rightSpace)
        }
        
        let bgView = UIView.init(frame: bounds)
        bgView.layer.insertSublayer(layer, at: 0)
        cell.backgroundView = bgView
    }

    
    private func layerLeftAndRight(layer:CALayer, addLineUp:Bool, isLong:Bool, color:CGColor, bounds:CGRect, leftSpace:CGFloat, rightSpace:CGFloat) {
        let lineLayer = CALayer.init()
        let lineHeight = (1.0 / UIScreen.main.scale)
        var left, right, top: CGFloat
        
        if addLineUp == true {
            top = 0
        } else {
            top = bounds.size.height-lineHeight
        }
        
        if isLong {
            left = 0
            right = 0
        } else {
            left = leftSpace
            right = rightSpace
        }
        
        //        lineLayer.frame = CGRectMake(bounds.minX+left, top, bounds.size.width-left, lineHeight);
        lineLayer.frame = CGRect(x: bounds.minX+left, y: top, width: bounds.size.width-left - right, height: lineHeight)
        lineLayer.backgroundColor = color;
        layer.addSublayer(lineLayer);
    }

}
