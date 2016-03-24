//
//  FMDBHelper.swift
//  Muslim
//
//  Created by LSD on 15/11/16.
//  Copyright © 2015年 ZoomBin. All rights reserved.
//

import UIKit

class FMDBHelper: NSObject {
    var dbPath:String
    var dbBase:FMDatabase
    
    
    //单例化
    class func getInstance()->FMDBHelper{
        struct psSingle{
            static var onceToken:dispatch_once_t = 0;
            static var instance:FMDBHelper? = nil
        }
        //保证单例只创建一次
        dispatch_once(&psSingle.onceToken,{
            psSingle.instance = FMDBHelper()
        })
        return psSingle.instance!
    }
    
    
    //创建数据库
    override init() {
        let path = FileUtils.documentsDirectory() + "/db/" + DBConstants.DB_NAME
        //是否存在
        if(!NSFileManager.defaultManager().fileExistsAtPath (path)){
            let dbZipPath = NSBundle.mainBundle().pathForResource(DBConstants.DB_ZIP_NAME, ofType: "")
            //解压zip包
            ZipUtils.unZipFile(dbZipPath!, unzipPath: FileUtils.documentsDirectory() + "/db/")
        }
        self.dbPath = path
        Log.printLog(dbPath)
        //创建数据库
        dbBase =  FMDatabase(path: self.dbPath as String)
        
        /*
        let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let fileURL = documents.URLByAppendingPathComponent(DBConstants.DB_NAME)
        
        self.dbPath = fileURL.path!
        Log.printLog(dbPath)
        //创建数据库
        dbBase = FMDatabase(path: fileURL.path)
        super.init()
        createTable()
        */
    }
    
    func copyDB(){
        let path = FileUtils.documentsDirectory() + "/db/" + DBConstants.DB_NAME
        //是否存在
        if(!NSFileManager.defaultManager().fileExistsAtPath (path)){
            let dbZipPath = NSBundle.mainBundle().pathForResource(DBConstants.DB_ZIP_NAME, ofType: "")
            //解压zip包
            ZipUtils.unZipFile(dbZipPath!, unzipPath: FileUtils.documentsDirectory() + "/db/")
        }
        self.dbPath = path
        Log.printLog(dbPath)
        //创建数据库
        dbBase =  FMDatabase(path: self.dbPath as String)
    }
    
    func createDB(){
        let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let fileURL = documents.URLByAppendingPathComponent(DBConstants.DB_NAME)
        
        self.dbPath = fileURL.path!
        Log.printLog(dbPath)
        //创建数据库
        dbBase = FMDatabase(path: fileURL.path)
    }
    
    func createTable(){
        //记录表
        let sql = "CREATE TABLE IF NOT EXISTS "
            + DBConstants.TB_Keepers + "("
            + "_id" + " INTEGER NOT NULL PRIMARY KEY autoincrement, "
            + "k_type" + " INTEGER NOT NULL, "
            + "k_logo" + " TEXT, "
            + "k_name" + " TEXT, "
            + "k_account" + " TEXT, "
            + "k_pass" + " TEXT, "
            + "k_remarks" + " TEXT "
            + ");"
        
        //类型表
        let sql_type = "CREATE TABLE IF NOT EXISTS "
            + "keepertype" + "("
            + "t_id" + " INTEGER NOT NULL PRIMARY KEY autoincrement, "
            + "t_name" + " TEXT, "
            + "t_logo" + " TEXT "
            + ");"
        
        dbBase.open()
        dbBase.executeUpdate(sql)
        dbBase.executeUpdate(sql_type)
        dbBase.close()
    }
    
    //添加
    func insertNewKeeper(type:Int,logo:String,name:String,account:String,pass:String,remarks:String){
        let sql = "INSERT INTO " + DBConstants.TB_Keepers +  " (k_type, k_logo, k_name,k_account, k_pass, k_remarks) VALUES (?, ?,?, ?, ?, ?)"
        executeSQLWithPama(sql, values: [type,logo,name,account,pass,remarks])
    }
    
    func insertNewType(name:String,logo:String){
        let sql = "INSERT INTO " + "keepertype" +  " (t_name,t_logo) VALUES (?, ?)"
        executeSQLWithPama(sql, values: [name,logo])
    }
    
    //删除
    func deleteKeeper(id:Int){
        let sql = "DELETE FROM " + DBConstants.TB_Keepers + " WHERE _id = ?"
        executeSQLWithPama(sql, values: [id])
    }
    
    func deleteType(id:Int){
        let sql = "DELETE FROM " + "keepertype" + " WHERE t_id = ?"
        executeSQLWithPama(sql, values: [id])
    }
    
    //修改
    func updateKeeper(id:Int,dy:NSDictionary){
        var sql = "UPDATE " + DBConstants.TB_Keepers + " SET "
        let keys =  dy.allKeys
        let values = NSMutableArray()
        for var i=0;i<keys.count;i++ {
            let key = keys[i] as! String
            let value = dy.objectForKey(key) as! String
            values.addObject(value)
            if(i == keys.count-1){
                sql = sql + key + "=? "
            }else{
                sql = sql + key + "=?, "
            }
        }
        sql = sql + "WHERE _id =\(id)"
        Log.printLog(sql)
        executeSQLWithPama(sql,values: values as [AnyObject])
    }
    
    func updateType(id:Int,dy:NSDictionary){
        var sql = "UPDATE " + "keepertype" + " SET "
        let keys =  dy.allKeys
        let values = NSMutableArray()
        for var i=0;i<keys.count;i++ {
            let key = keys[i] as! String
            let value = dy.objectForKey(key) as! String
            values.addObject(value)
            if(i == keys.count-1){
                sql = sql + key + "=? "
            }else{
                sql = sql + key + "=?, "
            }
        }
        sql = sql + "WHERE t_id =\(id)"
        executeSQL(sql)
    }
    
    //查询
    func queryKeeperByType(type:Int)->NSMutableArray{
        var sql = ""
        if(type == -1){
            sql = "SELECT * FROM " + DBConstants.TB_Keepers
        }else{
            sql = "SELECT * FROM " + DBConstants.TB_Keepers + " WHERE k_type = \(type)";
        }
        return matchKeeper(sql)
    }
    
    func queryKeeperById(id:Int)->NSMutableArray{
        let sql = "SELECT * FROM " + DBConstants.TB_Keepers + " WHERE _id = \(id)";
        return matchKeeper(sql)
    }
    
    func matchKeeper(sql:String)->NSMutableArray{
        let entitys = NSMutableArray()
        do{
            dbBase.open()
            let rs = try dbBase.executeQuery(sql, values: nil)
            while rs.next() {
                let entity = KeeperEntity()
                entity._id = Int(rs.intForColumn("_id"))
                entity.k_type = Int(rs.intForColumn("k_type"))
                entity.k_logo = rs.stringForColumn("k_logo")
                entity.k_name = rs.stringForColumn("k_name")
                entity.k_account = rs.stringForColumn("k_account")
                entity.k_pass = rs.stringForColumn("k_pass")
                entity.k_remarks = rs.stringForColumn("k_remarks")
                entitys.addObject(entity)
            }
            dbBase.close()
        }catch let error as NSError {
            Log.printLog("failed: \(error.localizedDescription)")
        }
        return entitys
    }
    
    func queryTypes()->NSMutableArray{
        let sql = "SELECT * FROM " +  "keepertype"
        let entitys = NSMutableArray()
        do{
            dbBase.open()
            let rs = try dbBase.executeQuery(sql, values: nil)
            while rs.next() {
                let entity = TypeEntity()
                entity.t_id = Int(rs.intForColumn("t_id"))
                entity.t_logo = rs.stringForColumn("t_logo")
                entity.t_name = rs.stringForColumn("t_name")
                entitys.addObject(entity)
            }
            dbBase.close()
        }catch let error as NSError {
            Log.printLog("failed: \(error.localizedDescription)")
        }
        return entitys
    }
    
    //当前分类最新一个
    func queryTypeMaxId()->Int{
        var count = 0
        let sql = "SELECT max(t_id) FROM " +  "keepertype"
        do{
            dbBase.open()
            let rs = try dbBase.executeQuery(sql, values: nil)
            rs.next()
            count = Int(rs.intForColumnIndex(0))
            dbBase.close()
        }catch let error as NSError {
            Log.printLog("failed: \(error.localizedDescription)")
        }
        return count
    }
    
    //当前分类中最新一个记录
    func queryKeeperMaxId()->Int{
        var count = 0
        let sql = "SELECT max(_id) FROM " + DBConstants.TB_Keepers
        do{
            dbBase.open()
            let rs = try dbBase.executeQuery(sql, values: nil)
            rs.next()
            count = Int(rs.intForColumnIndex(0))
            dbBase.close()
        }catch let error as NSError {
            Log.printLog("failed: \(error.localizedDescription)")
        }
        return count
    }
    
    //操作单个语句
    func executeSQL(sql:String) {
        dbBase.open()
        dbBase.executeStatements(sql)
        dbBase.close()
    }
    
    //带参数的操作语句
    func executeSQLWithPama(sql:String,values:[AnyObject]) {
        dbBase.open()
        do{
            try dbBase.executeUpdate(sql, values: values)
        }catch let error as NSError {
            Log.printLog("failed: \(error.localizedDescription)")
        }
        dbBase.close()
    }

}
