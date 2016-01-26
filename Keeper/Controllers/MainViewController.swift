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
        appVerifyActive() //验证
        //注: 设置title
        let titleLabel = UILabel(frame: CGRectMake((1/2) * PhoneUtils.screenWidth, 0, 90, 44))
        titleLabel.text = "Keeper"
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        titleLabel.textColor = UIColor.blackColor()
        self.navigationItem.titleView = titleLabel
        
        //title左边菜单
        let leftImage : UIImage =  UIImage(named: "ic_menu")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: leftImage, style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("funcLeftClick"))
        
        //title右边菜单
        let rightImage : UIImage =  UIImage(named: "ic_add")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightImage, style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("funcRightClick"))
        
        

        // Do any additional setup after loading the view.
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
