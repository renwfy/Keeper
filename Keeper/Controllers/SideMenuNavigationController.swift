//
//  SideMenuNavigationController.swift
//  Keeper
//
//  Created by LSD on 16/2/1.
//  Copyright © 2016年 renwfy.fr. All rights reserved.
//

import UIKit

protocol SideMenuNavigationDelegate : NSObjectProtocol {
    func onItemClick(type:Int)
    func onNewClick()
}
class SideMenuNavigationController: BaseViewController , UITableViewDelegate, UITableViewDataSource {
    var delegate:SideMenuNavigationDelegate?
    
    @IBOutlet weak var tableview: UITableView!
    let cellIdentifier = "menuCell"
    
    var datas = NSMutableArray()
    var select = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "菜单"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "编辑", style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("editType"))
        
        initView()
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
    }
    
    func initView(){
        tableview.delegate = self
        tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        tableview.backgroundColor = Colors.lightGray
        tableview!.registerNib(UINib(nibName: "MenuCell", bundle:nil), forCellReuseIdentifier: cellIdentifier)
        tableview.reloadData()
        
        let nibs : NSArray = NSBundle.mainBundle().loadNibNamed("MenuAdd", owner: nil, options: nil)
        let menuFootView = nibs.lastObject as! MenuAdd
        menuFootView.bt_newType.addTarget(self, action: Selector.init("addNewType:"), forControlEvents:UIControlEvents.TouchUpInside)
        tableview.tableFooterView = menuFootView
    }
    
    func loadData(){
        datas = FMDBHelper.getInstance().queryTypes()
        tableview.reloadData()
    }
    
    func editType(){
        if(tableview.editing){
            tableview.editing = false
            select = 0
            tableview.reloadData()
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "编辑", style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("editType"))
        }else{
            tableview.editing = true
            select = -1
            tableview.reloadData()
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("editType"))
        }
    }
    
    func addNewType(button:UIButton){
        delegate?.onNewClick()
        self.dismissViewControllerAnimated(true, completion: nil)
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
        let cell : MenuCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MenuCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let entity = datas.objectAtIndex(indexPath.row) as! TypeEntity
        cell.t_name.text = entity.t_name
        if(entity.t_logo?.isEmpty == false){
            let url = NSURL(fileURLWithPath: Constants.logoPath+entity.t_logo!)
            let data = NSData.init(contentsOfURL: url)
            cell.t_logo.image = UIImage.init(data: data!)
        }else{
            if(1 == entity.t_id){
                cell.t_logo.image = UIImage.init(named: "ic_card")
            }else if(2 == entity.t_id){
                cell.t_logo.image = UIImage.init(named: "ic_innet")
            }else if(3 == entity.t_id){
                cell.t_logo.image = UIImage.init(named: "ic_email")
            }else{
                cell.t_logo.image = UIImage.init(named: "ic_card")
            }
        }
        cell.t_select.hidden=true
        if(select == indexPath.row){
            cell.t_select.hidden = false
        }
        if(indexPath.row == datas.count-1){
            cell.line.hidden = true
        }else{
             cell.line.hidden = false
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
       
        select = indexPath.row
        tableView.reloadData()
        
        let entity = datas.objectAtIndex(indexPath.row) as! TypeEntity
        delegate?.onItemClick(entity.t_id!)
        self.performSelector(Selector.init("finish"), withObject: nil, afterDelay: 0.001)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        tableview.editing = false
        let entity = datas.objectAtIndex(indexPath.row) as! TypeEntity
        FMDBHelper.getInstance().deleteType(entity.t_id!)
        select = 0
        loadData()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "编辑", style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("editType"))
        let newentity = datas.objectAtIndex(0) as! TypeEntity
        delegate?.onItemClick(newentity.t_id!)
    }
    
    func finish(){
        self.dismissViewControllerAnimated(true, completion: nil)
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
