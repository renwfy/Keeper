//
//  MainViewController.swift
//  Keeper
//
//  Created by LSD on 15/12/30.
//  Copyright © 2015年 renwfy.fr. All rights reserved.
//

import UIKit

class MainViewController: VerifyViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //appVerifyActive() //验证
        //注: 设置title
        let titleLabel = UILabel(frame: CGRectMake((1/2) * PhoneUtils.screenWidth, 0, 50, 44))
        titleLabel.text = "Keeper"
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont.boldSystemFontOfSize(15)
        titleLabel.textColor = UIColor.blackColor()
        self.navigationItem.titleView = titleLabel
        
        //title左边菜单
        let leftImage : UIImage =  UIImage(named: "ic_menu")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: leftImage, style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("showMenu"))
        
        //title右边菜单
        let rightImage : UIImage =  UIImage(named: "ic_add")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightImage, style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("funcRightClick"))
        
        initMenu()
        // Do any additional setup after loading the view.
    }
    
    //侧滑菜单
    func initMenu(){
        // Define the menus
        
        let menuLeftNavigationController = UISideMenuNavigationController()
        menuLeftNavigationController.viewControllers = [SideMenuNavigationController()]
        menuLeftNavigationController.leftSide = true
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration of it here like setting its viewControllers.
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
    
    func showMenu(){
        presentViewController(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
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
