//
//  AlipayHeader.h
//  IntegratedAlipay
//
//  Created by Winann on 15/1/9.
//  Copyright (c) 2015年 Winann. All rights reserved.
//

/**
 *  1. 将本工程中的IntegratedAlipay文件夹导入工程中，记得选copy；
 *  2. 点击项目名称,点击“Build Settings”选项卡,在搜索框中,以关键字“search” 搜索,对“Header Search Paths”增加头文件路径:“$(SRCROOT)/项目名称/IntegratedAlipay/AlipayFiles”（注意：不包括引号，如果不是放到项目根目录下，请在项目名称后面加上相应的目录名）；
 *  3. 点击项目名称,点击“Build Phases”选项卡,在“Link Binary with Librarles” 选项中,新增“AlipaySDK.framework”和“SystemConfiguration.framework” 两个系统库文件。如果项目中已有这两个库文件,可不必再增加；
 *  4. 在本头文件中设置kPartnerID、kSellerAccount、kNotifyURL、kAppScheme和kPrivateKey的值（所有的值在支付宝回复的邮件里面：注意，建议除appScheme以外的字段都从服务器请求）；
 *  5. 点击项目名称,点击“Info”选项卡，在URL types里面添加一项，Identifier可以不填，URL schemes必须和appScheme的值相同，用于支付宝处理回到应用的事件；
 *  6. 在需要用的地方导入“AlipayHeader.h”，并使用“[AlipayRequestConfig alipayWithPartner:...”方法进行支付；
 *  7. 在AppDelegate中处理事件回调（可直接复制下面内容）：
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
 //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK if ([url.host isEqualToString:@"safepay"]) {
 [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
 NSLog(@"result = %@",resultDic);
 }];
 if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
 [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
 NSLog(@"result = %@",resultDic);
 }];
 }
 return YES;
 }
 */

#ifndef IntegratedAlipay_AlipayHeader_h
#define IntegratedAlipay_AlipayHeader_h


#import <AlipaySDK/AlipaySDK.h>     // 导入AlipaySDK
#import "AlipayRequestConfig.h"     // 导入支付类
#import "Order.h"                   // 导入订单类
#import "DataSigner.h"              // 生成signer的类：获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode

#import <Foundation/Foundation.h>   // 导入Foundation，防止某些类出现类似：“Cannot find interface declaration for 'NSObject', superclass of 'Base64'”的错误提示
/**
 *  partner:合作身份者ID,以 2088 开头由 16 位纯数字组成的字符串。
 *
 */
#define kPartnerID @"2088521415970912"

/**
 *  seller:支付宝收款账号,手机号码或邮箱格式。
 */
#define kSellerAccount @"govlan@126.com"

/**
 *  支付宝服务器主动通知商户 网站里指定的页面 http 路径。
 */
#define kNotifyURL @"https://m.govlan.com/api/1.0/user/aliNotify"

/**
 *  appSckeme:应用注册scheme,在Info.plist定义URLtypes，处理支付宝回调
 */
#define kAppScheme @"govlan"

/**
 *  private_key:商户方的私钥,pkcs8 格式。
 */

#define kPrivateKey @"MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC2U5Nxp2pl9eev26mW1PbHabto3BUGoyt0Bzf2ZeiwA7nvKyL19ij/PKMjE1Cc3NOImv/uQl8mgKkha6khN+fnnDSxwNhZptto3XF7bbMrq0azpdy4Nz0EF0ZDhrreFmugfxx6JUtY6jWwmout30o2DmDlovuoYP2ye36AgqR3+IXq6kHk9FTqwiqNDVBvnzKi7TF5f/HBRzqSiogo+hJw2iNu9sghJjFvvtCvB+LtUgjRYMkUSmrkznGst1Oo5iGPl9wdF2wzn9nl20f7M63UvR88bFHJGWiPenSdzlcMzCnK31b1mtZm+aRF+8ZLiEG5mwrZD98MFdRTxHSRP3HvAgMBAAECggEAHUAXPXqQVT84JjxlXq9Xz/IkgNQeA2yWAg1Oaxc6V1Kht78B4tfVB+2gdnYYzrGWtim3uW+oeDLX72aoQY4IhF3JDmNT0j40oQQ1uomE3xKhSxzm5h7miQt62EZ7IDoUljEOToJBLkiUyHpiwkg6TaXM4cpd+UtmKAYr604KOLy+MWuTZ4OKL7QqRUuk3dPwVoYr3OkbWvX9a9LbDS+k0abUgCW3JlqH6NlaIaO5VO7d2X7z2eKlxZZgt0XifEr547Hska7+8l1gccaM3m2amWx+y3Pxhp3wQxfffzGPei955q0zNKF73ugY+E2Lo/xUlm/cA/TT6pSHjzhO/xIFkQKBgQD4RQNI6wyGI9pqMuUXD8AC7E6FjPXQx3oqGiKAtKAG1sOGuLpVGmS/ZMRYS27S5zjqSlJx1u9SW4+xFWeFF1Pt8kHT5xqq4b8p0maAE/geG7E9x8FMEOGlD+sNMMHIupZvKPv9FL2gETlRrQFpdsS4iYomJMX9Yre8SpCeVdAV4wKBgQC8AOwpvnjiIMqVH1VQRmI51MA24PmKgB+MNsGPwZ3txI+F5dtEa/SrFQcoA9CBOnFKWJRe6dQRRkh7/EtuGHmOd4DIFiZspr+my6cRtDxEUJ0KgjAWXD4GMCHSSjR4m8SOHp94al4Z1nVImt1XMZS5YQtUtjdIR9EQZYkAqZARhQKBgQD2qNpSn/SZcRWXXWluOB+0x8JbvWicPROKsNyGsu4q3UT1nKLD2q0t2peYgZlhwIgzfhPbNogfcwiYD4QCHuMsDPyJ45oDHLYofvmHVk+02h6GGuhZAoysydvmBwMAwyCi4D07fFfJqFMiaph0h6N7FGtE6lQrIuEZGZwFM4zBsQKBgQCcOXwFmDSlW7BbyITBRyt6ePMc50gVsjAE+L9RsQeGO+8zyfSx36+ZtsiSlNDfgewAZqksUcwaarfy54zauNXR8DYAjn9xjAL4HIUBLi9iaUaGI/bHrfEQfVCtiWIe0vm7S3Eiw+jcOZyOL7o8KYQ3o4+h3iUEGEF/CZCWD1EbbQKBgQCWZgKHmkftxcLAZHIuOaNmlvmudzPsby0703efiqttYgfuB9kITWMUcbNb4TAWRqnjBpa/MamVG1cMBD9e2ddc+/dk+dLXbo0eh4Jg6B+oPPkN0RYT7R4KQKIF7L8AlaeYobFQnhlUjqp56qmX+nG1LbotyaE3dPO+kPtLB8vumg=="

#endif
