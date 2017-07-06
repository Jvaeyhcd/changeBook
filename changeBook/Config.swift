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
let kBasePadding = scaleFromiPhone6Desgin(x: 15)

// 分割线背景颜色
let kSplitLineBgColor = UIColor(hex: 0xEEEEEE)
//vc背景
let kMainBgColor = UIColor(hex: 0xF7F7F7)
let kMainColor = UIColor(hex: 0xF85B5A)
let kTabbarTintColor = UIColor(hex: 0x03A9F5)
let kNavTintColor = UIColor(hex: 0xFFFFFF)
let kSelectedCellBgColor = UIColor(hex: 0xF9F9F9)
//蓝色
let kBlueColor = UIColor(hex: 0x03a9f5)
//灰色
let kGaryColor = UIColor(hex: 0xBDBDBD)
//按钮默认状态背景颜色
let kBtnNormalBgColor = UIColor(hex: 0xF85B5A)
//按钮按下背景颜色
let kBtnTouchInBgColor = UIColor(hex: 0x0394D7)
//按钮不可点击背景颜色
let kBtnDisableBgColor = UIColor(hex: 0xDBDBDB)
//不可用颜色
let kDisableColor = UIColor(hex: 0xDEDEDE)

//字体大小
let kBarButtonItemTitleFont = UIFont.systemFont(ofSize: 16)
let kBaseFont = UIFont.systemFont(ofSize: 14)
let kSmallTextFont = UIFont.systemFont(ofSize: 12)

//默认头像
let kUserDefaultImage = UIImage(named: "default_pic.jpg")

let kHost = "http://120.77.85.241/app.php/"
//服务器基本地址
let kBaseUrl = kHost + "api/1.0"

let TIMEOUTTIME = 10
let TIMEOUTCODE = -1001

let MAN = "1"
let WOMAN = "2"

let kUserDefaults = UserDefaults.standard

let kServerSuccessCode = "200"
let kServerNeedLoginCode = "302"
let kServerFailedCode = "300"
let kOtherFailedCode = "500"
let kNoNeedCache = "noNeedCache"

// 全局变量判断是否显示登录界面
var showedLogin = false

func scaleFromiPhone6Desgin(x : CGFloat)->CGFloat{
    return (x * (kScreenWidth / 375))
}

let isDebug = true

func BLog(log:String) {
    if isDebug == true {
        print(log)
    }
}
