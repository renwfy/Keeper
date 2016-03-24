//
//  SettingsViewController.swift
//  Keeper
//
//  Created by LSD on 16/1/26.
//  Copyright © 2016年 renwfy.fr. All rights reserved.
//

import UIKit

class SettingsViewController: VerifyViewController ,UITableViewDelegate, UITableViewDataSource{
    let cellIdentifier = "settingsCell"
    @IBOutlet weak var mTableView: UITableView!
    var datas = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        initView()
    }
    
    override func viewWillAppear(animated: Bool) {
        var setEntity = SettingEntity();
        setEntity.name = "关于";
        setEntity.subText = "renwfy@126.com";
        setEntity.icon = "ic_about";
        datas.addObject(setEntity)
        
        setEntity = SettingEntity()
        setEntity.name = "支持";
        setEntity.subText = "暂未开放";
        setEntity.icon = "ic_zhichi";
        datas.addObject(setEntity)
    }
    
    func initView(){
        mTableView.delegate = self
        mTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        mTableView!.registerNib(UINib(nibName: "SettingsCell", bundle:nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    //设置每个item的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    //设置行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    //进行生成界面和赋值
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : SettingsCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SettingsCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let entity = datas.objectAtIndex(indexPath.row) as! SettingEntity
        cell.tvText.text = entity.name
        cell.tvSubText.text = entity.subText
        cell.ivIcon.image = UIImage.init(named: entity.icon!)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
