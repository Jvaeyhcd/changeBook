//
//  UIImage+Polesapp.swift
//  govlan
//
//  Created by polesapp-hcd on 2016/10/24.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

import Foundation
import UIKit

public enum ImageCompressType {
    case Session
    case Timeline
}

extension UIImage {
    
    func wxCompress(type: ImageCompressType = .Session) -> UIImage {
        
        let size = self.wxImageSize(type: type)
        let reImage = resizedImage(size: size)
        let data = UIImageJPEGRepresentation(reImage, 0.2)!
        
        return UIImage.init(data: data)!
        
    }
    
    private func wxImageSize(type: ImageCompressType) -> CGSize {
        var width = self.size.width
        var height = self.size.height
        
        var boundary: CGFloat = 1280
        
        if width < boundary && height < boundary {
            return CGSize(width: width, height: height)
        }
        
        let s = max(width, height) / min(width, height)
        if s <= 2 {
            // Set the larger value to the boundary, the smaller the value of the compression
            let x = max(width, height) / boundary
            if width > height {
                width = boundary
                height = height / x
            } else {
                height = boundary
                width = width / x
            }
        } else {
            // width, height > 1280
            if min(width, height) >= boundary {
                boundary = type == .Session ? 800 : 1280
                // Set the smaller value to the boundary, and the larger value is compressed
                let x = min(width, height) / boundary
                if width < height {
                    width = boundary
                    height = height / x
                } else {
                    height = boundary
                    width = width / x
                }
            }
        }
        return CGSize(width: width, height: height)
        
    }
    
    private func resizedImage(size: CGSize) -> UIImage {
        let newRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        var newImage: UIImage!
        
        UIGraphicsBeginImageContext(newRect.size)
        newImage = UIImage(cgImage: self.cgImage!, scale: 1, orientation: self.imageOrientation)
        newImage.draw(in: newRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    static func compressImage(sourceImage: UIImage, targetWidth: CGFloat) -> UIImage {
        let imageSize = sourceImage.size
        
        let width = imageSize.width
        let height = imageSize.height
        
        let targetHeight = (targetWidth / width) * height
        UIGraphicsBeginImageContext(CGSize(width: targetWidth, height: targetHeight))
        
//        sourceImage.drawInRect(CGRectMake(0, 0, targetWidth, targetHeight))
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func getPixelColor(pos:CGPoint) -> UIColor {
        let pixelData = self.cgImage!.dataProvider!.data
        let data = CFDataGetBytePtr(pixelData)
        let pixelInfo = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let red = CGFloat((data?[pixelInfo])!) / 255
        let green = CGFloat((data?[pixelInfo + 1])!) / 255
        let blue = CGFloat((data?[pixelInfo + 2])!) / 255
        let alpha = CGFloat((data?[pixelInfo + 3])!) / 255
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
}
