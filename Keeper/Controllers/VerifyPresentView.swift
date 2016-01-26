//
//  VerifyPresentView.swift
//  Keeper
//
//  Created by LSD on 16/1/26.
//  Copyright © 2016年 renwfy.fr. All rights reserved.
//

import UIKit
import LocalAuthentication

class VerifyPresentView: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        verifyWithTouchID()
    }
    
    func verifyWithTouchID(){
        let context = LAContext()
        var error: NSError?
        let errorReason = "输入指纹，解锁应用"
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error){
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: errorReason, reply: {
                (success, error) in
                if success {
                    //成功
                    self.performSelectorOnMainThread(Selector.init("dismissView"), withObject: nil, waitUntilDone: true)
                    Constants.APP_Verify = 0
                }
                else{
                    //错误
                }
            })
        }else{
            //不支持
        }
    }

    func dismissView(){
        self.dismissViewControllerAnimated(false,completion: nil);
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
