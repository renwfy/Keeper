//
//  DBConstants.swift
//  Muslim
//
//  Created by LSD on 15/11/17.
//  Copyright © 2015年 ZoomBin. All rights reserved.
//

import UIKit

class DBConstants: NSObject {
    // 数据库名称
    static let DB_NAME :String = "keeper.sqlite"
    static let DB_ZIP_NAME :String = "keeper.sqlite.zip"
    
    //表名
    static let TB_Keepers :String = "keepers"
    
    static let Field_ID :String = "_id"
    static let Field_TYPE :String = "k_type"
    static let Field_LOGO :String = "k_logo"
    static let Field_NAME :String = "k_name"
    static let Field_ACCOUNT :String = "k_account"
    static let Field_PASS :String = "k_pass"
    static let Field_REMARKS :String = "k_remarks"
    
}
