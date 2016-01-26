//
//  AppDelegate.swift
//  Keeper
//
//  Created by LSD on 15/12/30.
//  Copyright © 2015年 renwfy.fr. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //self.window!.backgroundColor = UIColor.whiteColor()
        
        initSplashVC()
        return true
    }
    
    //进入首页
    func initMainVC() {
        let vc = MainViewController()
        //创建导航控制器
        let nvc = UINavigationController(rootViewController:vc)
        //设置根视图
        self.window!.rootViewController = nvc
        self.window!.makeKeyAndVisible()
    }
    
    //进入闪屏页
    func initSplashVC() {
        let spVC = SplashViewController()
        self.window!.rootViewController = spVC
        self.window!.makeKeyAndVisible()
    }
    
    //进入Tab页
    func initTabView() {
        let tabBarController = UITabBarController()
        
        let nav1 = UINavigationController.init(rootViewController: MainViewController())
        let nav2 = UINavigationController.init(rootViewController: SettingsViewController())
        
        tabBarController.viewControllers = [nav1, nav2]
        self.window!.rootViewController = tabBarController
        self.window!.makeKeyAndVisible()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   
        //进入后台
        Constants.APP_InBackgroud = true
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if(Constants.APP_InBackgroud){
            Constants.APP_InBackgroud = false
            NSNotificationCenter.defaultCenter().postNotificationName("VerifyActive", object: nil)
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

