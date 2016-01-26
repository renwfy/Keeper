//
//  VerifyViewController.swift
//  Keeper
//
//  Created by LSD on 16/1/25.
//  Copyright © 2016年 renwfy.fr. All rights reserved.
//

import UIKit

class VerifyViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appVerifyActive", name: "VerifyActive", object: nil)
    }
    
    //认证
    func appVerifyActive(){
        if(Constants.APP_Verify == 0){
            Constants.APP_Verify = 1
            let verifyV = VerifyPresentView();
            self.presentViewController(verifyV, animated: false, completion: nil);
        }
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
