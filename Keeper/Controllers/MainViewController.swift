//
//  MainViewController.swift
//  Keeper
//
//  Created by LSD on 15/12/30.
//  Copyright © 2015年 renwfy.fr. All rights reserved.
//

import UIKit

class MainViewController: VerifyViewController,SideMenuNavigationDelegate, UITableViewDelegate, UITableViewDataSource{
    let cellIdentifier = "keeperCell"
    @IBOutlet weak var tableview: UITableView!
    var datas = NSMutableArray()
    var curKeeperType = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        appVerifyActive() //验证
        //注: 设置title
        let titleLabel = UILabel(frame: CGRectMake((1/2) * PhoneUtils.screenWidth, 0, 50, 44))
        titleLabel.text = "Keeper"
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        titleLabel.textColor = UIColor.blackColor()
        self.navigationItem.titleView = titleLabel
        
        //title左边菜单
        let leftImage : UIImage =  UIImage(named: "ic_menu")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: leftImage, style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("showMenu"))
        
        //title右边菜单
        let rightImage : UIImage =  UIImage(named: "ic_add")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightImage, style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("newKeeper"))
        
        initView()
        initMenu()
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData(curKeeperType)
    }
    
    func initView(){
        tableview.delegate = self
        tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        tableview!.registerNib(UINib(nibName: "KeeperCell", bundle:nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    //侧滑菜单
    func initMenu(){
        // Define the menus
        let menuLeftNavigationController = UISideMenuNavigationController()
        let controller  = SideMenuNavigationController()
        controller.delegate = self
        menuLeftNavigationController.viewControllers = [controller]
        menuLeftNavigationController.leftSide = true
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration of it here like setting its viewControllers.
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuWidth = Constants.menuWidth
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
    func loadData(type:Int){
        datas = FMDBHelper.getInstance().queryKeeperByType(type)
        tableview.reloadData()
    }
    
    func showMenu(){
        presentViewController(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    func newKeeper(){
        let newKeeperViewController : NewKeeperViewController = NewKeeperViewController()
        newKeeperViewController.hidesBottomBarWhenPushed = true
        newKeeperViewController.keeperType = curKeeperType
        newKeeperViewController.opType = NewKeeperViewController.OPType.EDIT
        self.navigationController?.pushViewController(newKeeperViewController, animated: true)
    }
    
    func showKeeper(keeperId:Int){
        let newKeeperViewController : NewKeeperViewController = NewKeeperViewController()
        newKeeperViewController.hidesBottomBarWhenPushed = true
        newKeeperViewController.keeperId = keeperId
        newKeeperViewController.opType = NewKeeperViewController.OPType.DISPLAY
        self.navigationController?.pushViewController(newKeeperViewController, animated: true)
    }
    
    func newType(){
        let newTypeViewController : NewTypeViewController = NewTypeViewController()
        newTypeViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newTypeViewController, animated: true)
    }
    
    
    //设置每个item的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    //设置行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    //进行生成界面和赋值
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : KeeperCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! KeeperCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let entity = datas.objectAtIndex(indexPath.row) as! KeeperEntity
        let logo = entity.k_logo
        if(logo?.isEmpty == true || logo == nil){
            cell.setShowStyle(indexPath.row, style: KeeperCell.ShowStyle.TXT)
            cell.txt.font = UIFont(name: "STHeitiK-Light", size: 22)
            let showName = entity.k_name! as NSString
            cell.txt.text = showName.substringToIndex(1)
        }else{
            cell.setShowStyle(indexPath.row, style: KeeperCell.ShowStyle.IMG)
            let url = NSURL(fileURLWithPath: Constants.logoPath+entity.k_logo!)
            let data = NSData.init(contentsOfURL: url)
            cell.img.image = UIImage.init(data: data!)
        }
        cell.tvTitle.text = entity.k_name
        cell.tvContent.text = entity.k_account
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let entity = datas.objectAtIndex(indexPath.row) as! KeeperEntity
        showKeeper(entity._id!)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        let entity = datas.objectAtIndex(indexPath.row) as! KeeperEntity
        FMDBHelper.getInstance().deleteKeeper(entity._id!)
        loadData(curKeeperType)
    }

    
    
    //菜单界面操作
    func onItemClick(type:Int){
        curKeeperType = type
        loadData(type)
    }
    func onNewClick(){
       self.performSelector(Selector.init("newType"), withObject: nil, afterDelay: 0.001)
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
