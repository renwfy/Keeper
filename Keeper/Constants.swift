//
//  Constants.swift
//  Keeper
//
//  Created by LSD on 16/1/25.
//  Copyright © 2016年 renwfy.fr. All rights reserved.
//

import UIKit

class Constants: NSObject {
    static var APP_Verify = 0  //0 ：需要验证  , 1：已验证
    static var APP_InBackgroud = false
    
    static let menuWidth = PhoneUtils.screenWidth * 3.2/4
    
    static let logoPath = FileUtils.documentsDirectory()+"/logo/"
    
   
}
