//
//  FileUtils.swift
//  Muslim
//
//  Created by LSD on 15/11/16.
//  Copyright © 2015年 ZoomBin. All rights reserved.
//

import UIKit

class FileUtils: NSObject {
    
    /**APP documents路径*/
    static func documentsDirectory() ->String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths.first! as String
        return documentsDirectory
    }
    
    /**读取路径下的文件内容*/
    static func readFile(path:String) ->String{
        let str : String = try! String(contentsOfFile: path)
        return str 
    }
    
    /**存图片*/
    static func writeImageFile(image:UIImage,fileFullName:String){
        let path = Constants.logoPath
        let data = UIImagePNGRepresentation(image)
        writeFileToDocuments(data!, path: path, fileFullName: fileFullName)
    }
    
    /***存文件*/
    static func writeFileToDocuments(fileData:NSData,path:String,fileFullName:String){
        if(!NSFileManager.defaultManager().fileExistsAtPath (path)){
            try! NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        }
        let url: NSURL = NSURL(fileURLWithPath: path+fileFullName)
        Log.printLog(url)
        let data = NSMutableData()
        data.appendData(fileData)
        data.writeToFile(url.path!, atomically: true)
    }

}
