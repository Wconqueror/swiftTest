//
//  Constant.swift
//  Test
//
//  Created by 王得胜 on 2019/11/12.
//  Copyright © 2019 王得胜. All rights reserved.
//

import Foundation
import SnapKit

public let screenWidth = UIScreen.main.bounds.size.width
public let screenHeight = UIScreen.main.bounds.size.height
public let kStatusBarHeight = UIApplication.shared.statusBarFrame.height
public let kSaveBottomHeight : CGFloat = iPhone_X ? 34.0 : 0.0
public let Height_NavBar = 44 + kStatusBarHeight
public let Height_TabBar = 49 + kSaveBottomHeight

// MARK: - 屏幕分辨率
public let kScale = UIScreen.main.scale
// MARK: - 手机尺寸
public let iPhone_3_5 = (screenHeight * kScale == 960 ? true : false)  // iPhone 4/4s                960x640@2x
public let iPhone_4_0 = (screenHeight * kScale == 1136 ? true : false) // iPhone 5/5s/SE             1136x640@2x
public let iPhone_4_7 = (screenHeight * kScale == 1334 ? true : false) // iPhone 6/6s/7/7s/8         1334x750@2x
public let iPhone_5_5 = (screenHeight * kScale == 2208 ? true : false) // iPhone 6P/6sP/7P/7sP/8P    2208x1242@3x
public let iPhone_5_8 = (screenHeight * kScale == 2436 ? true : false) // iPhone X/Xs                2436x1125@3x
public let iPhone_6_1 = (screenHeight * kScale == 1792 ? true : false) // iPhone XR                  1792x828@2x
public let iPhone_6_5 = (screenHeight * kScale == 2688 ? true : false) // iPhone Xs Max              2688x1242@3x

public let iPhone_X = (Int((screenHeight / screenWidth) * 100) == 216 ? true : false) // 刘海屏


//Mark : 快速创建一个RGB颜色
public func kRGBColor(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat = 1.0) -> UIColor {
    return UIColor(red: (r) / 255.0, green: (g) / 255.0, blue: (b) / 255.0, alpha: a);
}

public func kHexColor(hexColor:String) -> UIColor{
    return kRandomColor()
}

public func kRandomColor() -> UIColor{
    return kRGBColor(CGFloat(arc4random_uniform(UInt32(255))), CGFloat(arc4random_uniform(UInt32(255))), CGFloat(arc4random_uniform(UInt32(255))))
}
