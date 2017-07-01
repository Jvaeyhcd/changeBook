//
//  Config.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation

let kScreenBounds = UIScreen.main.bounds
let kScreenWidth = kScreenBounds.width
let kScreenHeight = kScreenBounds.height
let kNavHeight = CGFloat(64)
let kTabBarHeight = CGFloat(49)
let kStatusBarHeight = CGFloat(20)
let kSegmentBarHeight = CGFloat(44)

// 分割线背景颜色
let kSplitLineBgColor = UIColor(hex: 0xEEEEEE)
//vc背景
let kMainBgColor = UIColor(hex: 0xF7F7F7)
let kMainColor = UIColor(hex: 0xF85B5A)
let kTabbarTintColor = UIColor(hex: 0x03A9F5)
let kNavTintColor = UIColor(hex: 0xFFFFFF)
let kSelectedCellBgColor = UIColor(hex: 0xF9F9F9)
let kBasePadding = scaleFromiPhone6Desgin(x: 15)


//字体大小
let kBarButtonItemTitleFont = UIFont.systemFont(ofSize: 16)
let kBaseFont = UIFont.systemFont(ofSize: 14)
let kSmallTextFont = UIFont.systemFont(ofSize: 12)

func scaleFromiPhone6Desgin(x : CGFloat)->CGFloat{
    return (x * (kScreenWidth / 375))
}
