//
//  AppDelegate.swift
//  changeBook
//
//  Created by Jvaeyhcd on 14/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import ReachabilitySwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var lastPlaySoundDate: Date?
    var reachability: Reachability = Reachability()!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setRootViewController()
        setGolbalUIConfig()
        startReachability()
        
        configUSharePlatforms()
        confitUShareSettings()
        
        configEMChat()
        registerRemoteNotification()
        
        return true
    }
    
    // 开始观察网络变化
    private func startReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    // 设置根界面
    private func setRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
//        let rootViewController = RootViewController.init(rootViewController: RootTabBarViewController())
//        rootViewController?.leftViewController = MenuViewController()
        window?.rootViewController = RootTabBarViewController()//BaseNavigationController.init(rootViewController: rootViewController!)
        
        window?.makeKeyAndVisible()
    }
    
    // 设置全局的UI样式
    private func setGolbalUIConfig() {
        
        UINavigationBar.appearance().barTintColor = kMainColor
        UINavigationBar.appearance().backgroundColor = kMainColor
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18),NSForegroundColorAttributeName: kNavTintColor!]
        
        // 设置字体颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(hex: 0x919191)!], for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: kMainColor!], for: UIControlState.selected)
        // 设置字体大小
//        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12.0)], for: UIControlState.normal)
        // 设置字体偏移
//        UITabBarItem.appearance().titlePositionAdjustment = UIOffsetMake(0.0, -5.0)
        // 设置图标选中时颜色
        UITabBar.appearance().tintColor = kMainColor
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        EMClient.shared().applicationDidEnterBackground(application)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        EMClient.shared().applicationWillEnterForeground(application)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // 支持所有iOS系统
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
        let result = UMSocialManager.default().handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
        if !result {
            // 其他如支付等SDK的回调
        }
        return result
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result {
            // 其他如支付等SDK的回调
        }
        return result
    }
    
    // MARK: - ReachabilitySwift
    
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                BLog(log: "Reachable via WiFi")
            } else {
                BLog(log: "Reachable via Cellular")
            }
            kUserDefaults.set(true, forKey: "networkWorked")
            kUserDefaults.synchronize()
        } else {
            kUserDefaults.set(false, forKey: "networkWorked")
            kUserDefaults.synchronize()
        }
        
        
    }
    
    // 配置环信
    private func configEMChat() {
        let options = EMOptions.init(appkey: kEMAppkey)
        options?.apnsCertName = kEMAPNSCertName
        let error = EMClient.shared().initializeSDK(with: options)
        if nil == error {
            BLog(log: "初始化成功")
        }
    }

    // 代码注册离线通知
    func registerRemoteNotification() {
        let application  = UIApplication.shared
        application.applicationIconBadgeNumber = 0
        
        if application.responds(to: #selector(UIApplication.registerUserNotificationSettings(_:))) {
            let notificationTypes:UIUserNotificationType = [.badge,.sound,.alert] as UIUserNotificationType
            let settings = UIUserNotificationSettings.init(types: notificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        let notificationTypes:UIUserNotificationType = [.badge,.sound,.alert]
        let settings = UIUserNotificationSettings.init(types: notificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        
        EMClient.shared().chatManager.add(self, delegateQueue: nil)
    }
}

// MARK: - U-Share

extension AppDelegate {
    
    fileprivate func configUSharePlatforms() {
        
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = kUMAppKey
        
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: kQQAppId, appSecret: kQQAppKey, redirectURL: "http://mobile.umeng.com/social")
        
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: kWXAppId, appSecret: kWXAppSecret, redirectURL: nil)
        
        UMSocialUIManager.setPreDefinePlatforms([NSNumber(integerLiteral:UMSocialPlatformType.wechatSession.rawValue), NSNumber(integerLiteral:UMSocialPlatformType.wechatTimeLine.rawValue), NSNumber(integerLiteral:UMSocialPlatformType.QQ.rawValue), NSNumber(integerLiteral:UMSocialPlatformType.qzone.rawValue)])
    }
    
    fileprivate func confitUShareSettings() {
        //是否打开图片水印
        UMSocialGlobal.shareInstance().isUsingWaterMark = false
        
        /*
         * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
         <key>NSAppTransportSecurity</key>
         <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
         </dict>
         */
        UMSocialGlobal.shareInstance().isUsingHttpsWhenShareContent = false
    }
    
}

extension AppDelegate: EMChatManagerDelegate, EMClientDelegate {
    
    func messagesDidReceive(_ aMessages: [Any]!) {
        let state: UIApplicationState = UIApplication.shared.applicationState
        switch state {
        case .active:
            // 播放声音和振动
            self.playSoundAndVibration()
        case .inactive:
            self.playSoundAndVibration()
        case .background:
            for item in aMessages {
                setupUnreadMessageCount()
                self.showNotificationWithMessage(message: item as! EMMessage)
            }
        }
    }
    
    func playSoundAndVibration() {
        if self.lastPlaySoundDate == nil || Date().timeIntervalSince(lastPlaySoundDate!) > 3.0 {
            EMCDDeviceManager.sharedInstance().playNewMessageSound()
            
            EMCDDeviceManager.sharedInstance().playVibration()
            self.lastPlaySoundDate = Date()
        }
    }
    
    func setupUnreadMessageCount() {
        let application = UIApplication.shared
        var applicationUnreadNum = application.applicationIconBadgeNumber + 1
        if applicationUnreadNum > 99 {
            applicationUnreadNum = 99
        }
        application.applicationIconBadgeNumber = applicationUnreadNum
    }
    
    // 本地消息推送
    func showNotificationWithMessage(message:EMMessage){
        let options = EMClient.shared().pushOptions
        let notification = UILocalNotification()
        notification.fireDate = Date()
        if options?.displayStyle == EMPushDisplayStyleMessageSummary {
            
        } else {
            let messageBody = message.body
            switch messageBody!.type {
            case EMMessageBodyTypeText:
                notification.alertBody = "您收到一条文字消息"
                break
            case EMMessageBodyTypeImage:
                notification.alertBody = "您收到一条图片消息"
                
                break
            case EMMessageBodyTypeLocation:
                notification.alertBody = "您收到一条位置消息"
                
                break
            case EMMessageBodyTypeVoice:
                notification.alertBody = "您收到一条声音消息"
                
                break
            case EMMessageBodyTypeVideo:
                notification.alertBody = "您收到一条视频消息"
                
                break
            case EMMessageBodyTypeFile:
                notification.alertBody = "您收到一条文字消息"
                break
            default:
                break
            }
            notification.alertAction = "打开"
            notification.timeZone = NSTimeZone.default
            if self.lastPlaySoundDate == nil || Date().timeIntervalSince(self.lastPlaySoundDate!) > 3.0 {
                notification.soundName = UILocalNotificationDefaultSoundName
                self.lastPlaySoundDate = Date()
            }
            //发送通知
            UIApplication.shared.scheduleLocalNotification(notification)
        }
    }
}

