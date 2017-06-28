//
//  String+Polesapp.swift
//  govlan
//
//  Created by polesapp-hcd on 2017/4/6.
//  Copyright © 2017年 Jvaeyhcd. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    //浏览数和播放次数的规则
    func ViewsAndPlayCounts() -> String {
        if "" == self{
            return "0"
        }
        
        let count = Int64.init(self)
        if count! < 1000{
            return "\(count!)"
        }else if count! >= 1000 && count! < 10000{
            let countK = String.init(format: "%.1f",  Double.init(count!) / 1000) + "k"
            return countK
        }else if count! >= 10000{
            let countW = String.init(format: "%.1f", Double.init(count!) / 10000) + "w"
            return countW
        }else{
            return "太多"
        }
    }
    
    //判断是否满足传入的正则表达式
    func fulfilRegularExpression(regex:String) -> Bool {
        var result = false
        let test = NSPredicate(format: "SELF MATCHES %@" , regex)
        
        result = (test.evaluate(with: self))
        
        return result;
    }
    
    //判断是否是URL地址
    func isURL() -> Bool {
        
        var result = false
        
        let urlRegex = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$";
        let urlTest = NSPredicate(format: "SELF MATCHES %@" , urlRegex)
        
        result = (urlTest.evaluate(with: self))
        
        return result
    }
    
    //验证电话号码
    func isPhoneNumber() -> Bool {
        
        var result = false
        
        let phoneRegex = "^((13[0-9])|(17[0-9])|(14[^4,\\D])|(15[^4,\\D])|(18[0-9]))\\d{8}$|^1(7[0-9])\\d{8}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@" , phoneRegex)
        
        result = (phoneTest.evaluate(with: self))
        
        return result;
    }
    
    //验证邮箱格式
    func validateEmail() -> Bool {
        if self.characters.count == 0 {
            return false
        }
//        if self.rangeOfString("@") == nil || self.rangeOfString(".") == nil{
//            return false
//        }

        if self.range(of: "@") == nil || self.range(of: ".") == nil {
            return false
        }
        
//        let invalidCharSet = NSCharacterSet.alphanumericCharacterSet().invertedSet.mutableCopy()
        var invalidCharSet = NSCharacterSet.alphanumerics.inverted
        invalidCharSet.remove(charactersIn: "_-")
        
        let range1 = self.range(of: "@")
        let index = range1?.lowerBound
        
        let usernamePart = self.substring(to: index!)
        let stringsArray1 = usernamePart.components(separatedBy: ".")
        
        for  string1 in stringsArray1
        {
            let rangeOfInavlidChars = string1.rangeOfCharacter(from: invalidCharSet)
            if rangeOfInavlidChars != nil || string1.characters.count == 0  {
                return false
            }
        }
        
//        let domainPart = self.substringFromIndex((index?.advancedBy(1))!)
        let domainPart = self.substring(from: self.index(index!, offsetBy: 1))
        let stringsArray2 = domainPart.components(separatedBy: ".")
        
        for  string1 in stringsArray2
        {
//            let rangeOfInavlidChars = string1.rangeOfCharacterFrom(invalidCharSet as! NSCharacterSet)
            let rangeOfInavlidChars = string1.rangeOfCharacter(from: invalidCharSet)
            if rangeOfInavlidChars != nil || string1.characters.count == 0  {
                return false
            }
        }
        
        return true
    }
    
    //验证邮编格式
    func isZipCodeNumber() -> Bool {
        if self.characters.count == 0 {
            return false
        }
        let zipCodeNumber = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let regexCodeNumber = NSPredicate(format: "SELF MATCHES %@",zipCodeNumber)
        if regexCodeNumber.evaluate(with: self) == true {
            return true
        }else
        {
            return false
        }
    }
    
    //判断是否是纯数字
    func validateNumber() -> Bool {
        let nsStr = NSString(string: self)
        var res = true
        let temSet = NSCharacterSet(charactersIn: "0123456789")
        var i = 0
        while i < nsStr.length {
            let str:NSString = nsStr.substring(with: NSMakeRange(i, 1)) as NSString
            let range:NSRange = str.rangeOfCharacter(from: temSet as CharacterSet)
            if range.length == 0 {
                res = false
                break
            }
            i = i+1
            
        }
        return res
        
    }
    
    
    
    //判断是否是纯字母
    //只能输入字母
    func validateLetter() -> Bool {
        let nsStr = NSString(string: self)
        var res = true
        let tmSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXWZ")
        var i = 0
        while i < nsStr.length {
            let string1:NSString = (nsStr as NSString).substring(with: NSMakeRange(i, 1)) as NSString
            let range = string1.rangeOfCharacter(from: tmSet as CharacterSet)
            if (range.length == 0) {
                res = false
                break;
            }
            i = i+1
        }
        return res
    }
    
    /**
     根据字体和约束条件计算文字的Size
     
     - parameter constraintSize: 约束Size
     - parameter font:           字体大小
     
     - returns: 最终计算出来的size
     */
    func getStrSize(constraintSize: CGSize, font: UIFont) -> CGSize {
        let boundingBox = self.boundingRect(with: constraintSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.size
    }
    
    /**
     根据字体和宽度计算文字高度
     
     - parameter width: 约束宽度
     - parameter font:  字体大小
     
     - returns: 高度
     */
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    /**
     根据字体和宽度计算文字宽度
     
     - parameter width: 约束宽度
     - parameter font:  字体大小
     
     - returns: 宽度
     */
    func widthWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.width
    }
    
    //    /**
    //     计算文字高度，可以处理急速那带行间距的
    //     */
    //    func boundingRectWithSize(size:CGSize, paragraphStyle:NSMutableParagraphStyle, font:UIFont) -> CGSize {
    //        var attributeString = NSMutableAttributedString(string: self)
    //        attributeString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, self.characters.count))
    //        attributeString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, self.characters.count))
    //        var options = [NSStringDrawingOptions.UsesLineFragmentOrigin , NSStringDrawingOptions.UsesFontLeading]
    //        var rect = attributeString.boundingRectWithSize(size, options: options, context: nil)
    //
    //        //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    //        if (rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing {
    //            if self.containChinese(self) {
    //                //如果包含中文
    //                rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - paragraphStyle.lineSpacing)
    //            }
    //        }
    //
    //        return rect.size
    //    }
    
    /**
     判断是否包含该中文
     */
    func containChinese(str:NSString) -> Bool{
        for i in 0 ..< str.length {
            let a = str.character(at: i)
            if a > 0x4e00 && a < 0x9fff {
                return true
            }
        }
        return false
    }
    
    /**
     时间戳转时间
     */
    func stringToTimeStamp() -> String {
        let string = NSString.init(string: self)
        let timeSta:TimeInterval = string.doubleValue
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy年MM月"
        //        timeFormatter.dateFormat = "yyyy年MM月dd日"
        let date = Date.init(timeIntervalSince1970: timeSta)
        return timeFormatter.string(from: date)
    }
    
    //验证身份证号格式
    func validateIDCardNumber()->Bool{
        
        let value = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        var length = 0
        if value == ""{
            return false
        }else{
            length = value.characters.count
            if length != 15 && length != 18{
                return false
            }
        }
        
        //省份代码
        let arearsArray = ["11","12", "13", "14",  "15", "21",  "22", "23",  "31", "32",  "33", "34",  "35", "36",  "37", "41",  "42", "43",  "44", "45",  "46", "50",  "51", "52",  "53", "54",  "61", "62",  "63", "64",  "65", "71",  "81", "82",  "91"]
        let valueStart2 = (value as NSString).substring(to: 2)
        var arareFlag = false
        if arearsArray.contains(valueStart2){
            
            arareFlag = true
        }
        if !arareFlag{
            return false
        }
        var regularExpression = NSRegularExpression()
        
        var numberofMatch = Int()
        var year = 0
        switch (length){
        case 15:
            year = Int((value as NSString).substring(with: NSRange(location:6,length:2)))!
            if year%4 == 0 || (year%100 == 0 && year%4 == 0){
                do{
                    regularExpression = try NSRegularExpression.init(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$", options: .caseInsensitive) //检测出生日期的合法性
                    
                }catch{
                    
                    
                }
                
                
            }else{
                do{
                    regularExpression =  try NSRegularExpression.init(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$", options: .caseInsensitive) //检测出生日期的合法性
                    
                }catch{}
            }
            
//            numberofMatch = regularExpression.numberOfMatchesInString(value, options:NSMatchingOptions.ReportProgress, range: NSMakeRange(0, value.characters.count))
            numberofMatch = regularExpression.numberOfMatches(in: value, options: .reportProgress, range: NSMakeRange(0, value.characters.count))
            
            if(numberofMatch > 0) {
                return true
            }else {
                return false
            }
            
        case 18:
            year = Int((value as NSString).substring(with: NSRange(location:6,length:4)))!
            if year%4 == 0 || (year%100 == 0 && year%4 == 0){
                do{
                    regularExpression = try NSRegularExpression.init(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive) //检测出生日期的合法性
                    
                }catch{
                    
                }
            }else{
                do{
                    regularExpression =  try NSRegularExpression.init(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive) //检测出生日期的合法性
                    
                }catch{}
            }
            
//            numberofMatch = regularExpression.numberOfMatchesInString(value, options:NSMatchingOptions.ReportProgress, range: NSMakeRange(0, value.characters.count))
            numberofMatch = regularExpression.numberOfMatches(in: value, options: .reportProgress, range: NSMakeRange(0, value.characters.count))
            
            if(numberofMatch > 0) {
                let s =
                    (Int((value as NSString).substring(with: NSRange(location:0,length:1)))! +
                        Int((value as NSString).substring(with: NSRange(location:10,length:1)))!) * 7 +
                        (Int((value as NSString).substring(with: NSRange(location:1,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:11,length:1)))!) * 9 +
                        (Int((value as NSString).substring(with: NSRange(location:2,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:12,length:1)))!) * 10 +
                        (Int((value as NSString).substring(with: NSRange(location:3,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:13,length:1)))!) * 5 +
                        (Int((value as NSString).substring(with: NSRange(location:4,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:14,length:1)))!) * 8 +
                        (Int((value as NSString).substring(with: NSRange(location:5,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:15,length:1)))!) * 4 +
                        (Int((value as NSString).substring(with: NSRange(location:6,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:16,length:1)))!) *  2 +
                        Int((value as NSString).substring(with: NSRange(location:7,length:1)))! * 1 +
                        Int((value as NSString).substring(with: NSRange(location:8,length:1)))! * 6 +
                        Int((value as NSString).substring(with: NSRange(location:9,length:1)))! * 3
                
                let Y = s%11
                var M = "F"
                let JYM = "10X98765432"
                
                M = (JYM as NSString).substring(with: NSRange(location:Y,length:1))
                if M == (value as NSString).substring(with: NSRange(location:17,length:1))
                {
                    return true
                }else{return false}
                
                
            }else {
                return false
            }
            
        default:
            return false
        }
        
    }
    
    // 判断是否是空字符串（只有空格和换行组成的字符串）
    func isBlankString() -> Bool {
        if "" == self {
            return true
        }
        
        let set = NSCharacterSet .whitespacesAndNewlines
        
        let trimedString = self.trimmingCharacters(in: set)
        
        if trimedString.characters.count == 0 {
            return true
        }
        return false
    }
    
    // String转float
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    
    var intValue: Int {
        return (self as NSString).integerValue
    }
    
    // 过滤掉所有换行、空格和Tab
    func removeAllSpaceAndNewline() -> String {

        var str = self.replacingOccurrences(of: " ", with: "")
        str = str.replacingOccurrences(of: " ", with: "")
        str = str.replacingOccurrences(of: "\r", with: "")
        str = str.replacingOccurrences(of: "\n", with: "")
        return str
    }
    
    // 只过滤掉头和尾的换行、空格和Tab
    func removeBothSideSpaceAndNewline() -> String {

        let temp = self.trimmingCharacters(in: .whitespaces)
        
        let str = temp.trimmingCharacters(in: .whitespacesAndNewlines)
        return str
    }
    
    // 将10个以上连续的空格替换成10个空格
    func replaceMoreThan10SpaceTo10Space() -> String {
        
        var result = ""
        
        // 记录当前连续空格个数
        var seriesSpaceNumber = 0
        
        for c in self.characters {
            if c == " " || c == "\t" {
                if seriesSpaceNumber < 10 {
                    result.append(c)
                    seriesSpaceNumber += 1
                }
            } else {
                result.append(c)
                seriesSpaceNumber = 0
            }
        }
        
        return result
    }
    
    //将两个以上连续换行符替换成1一个换行
    func replaceMoreThan1NewLineTo1NewLine() -> String {
        var result = ""
        
        // 记录当前连续空格个数
        var seriesSpaceNumber = 0
        
        for c in self.characters {
            if c == "\n" {
                if seriesSpaceNumber < 1 {
                    result.append(c)
                    seriesSpaceNumber += 1
                }
            } else {
                result.append(c)
                seriesSpaceNumber = 0
            }
        }
        
        return result
    }
    
    func ruledInputString() -> String {
        // 去掉头尾的空格、换行和Tab
        var content = self.removeBothSideSpaceAndNewline()
        // 将换行替换成空格
        content = content.replacingOccurrences(of: "\n", with: " ")
        // 将中间连续十个以上的空格替换成十个
        content = content.replaceMoreThan10SpaceTo10Space()
        
        return content
    }
    
    func subStrToIndex(index: Int) -> String {
        return (self as NSString).substring(to: index)
    }
}
