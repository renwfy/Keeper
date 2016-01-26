//
//  SplashViewController.swift
//  Keeper
//
//  Created by LSD on 15/12/30.
//  Copyright © 2015年 renwfy.fr. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSelector(Selector.init("goToMain"), withObject: nil, afterDelay: 2.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToMain() {
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.initTabView()
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
