//
//  PayPresenter.swift
//  govlan
//
//  Created by Jvaeyhcd on 27/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WXPayParameter {
    var appid : String
    var noncestr : String
    var package : String
    var partnerid : String
    var prepayid : String
    var timestamp : String
    var sign : String
    
    init(json: JSON) {
        appid = json["appid"].stringValue
        noncestr = json["noncestr"].stringValue
        package = json["package"].stringValue
        partnerid = json["partnerid"].stringValue
        prepayid = json["prepayid"].stringValue
        timestamp = json["timestamp"].stringValue
        sign = json["sign"].stringValue
    }
}

extension WXPayParameter: Decodable {
    
    static func fromJSON(json: Any) -> WXPayParameter {
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        let parameter = WXPayParameter.init(json: data)
        return parameter
    }
    
}

protocol PayPresenter {
    
    func wechatPayWithParameter(payParameter: WXPayParameter)
    func alipayWithOrderStr(orderStr: String)
}

extension PayPresenter {
    func wechatPayWithParameter(payParameter: WXPayParameter) {
        
        let req = PayReq()
        
        req.partnerId =  payParameter.partnerid
        req.package = payParameter.package
        req.sign = payParameter.sign
        req.nonceStr = payParameter.noncestr
        req.timeStamp =  UInt32(payParameter.timestamp)!
        req.prepayId = payParameter.prepayid
        
        let result = WXApi.send(req)
        if result == true {
            BLog(log: "成功！")
        } else {
            BLog(log: "失败！")
        }
        
    }
    
    func alipayWithOrderStr(orderStr: String) {
        AlipaySDK.defaultService().payOrder(orderStr, fromScheme: kAppScheme) { (resultDic) in
            
        }
    }
    
}
