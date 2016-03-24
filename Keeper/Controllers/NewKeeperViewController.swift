//
//  NewKeeperViewController.swift
//  Keeper
//
//  Created by LSD on 16/2/1.
//  Copyright © 2016年 renwfy.fr. All rights reserved.
//

import UIKit

class NewKeeperViewController: BaseViewController {
    internal enum OPType : Int {
        case EDIT
        case DISPLAY
    }
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var icLogo: UIImageView!
    @IBOutlet weak var tvAcount: UITextField!
    @IBOutlet weak var tvPass: UITextField!
    @IBOutlet weak var showpass: UIImageView!
    @IBOutlet weak var tvName: UITextField!
    
    var opType:OPType = .DISPLAY // 默认显示
    var keeperId : Int?
    var keeperType : Int?
    
    var isUpdateKeeper = false
    var logo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "添加新账号"
        
        //title右边菜单
        var rightTxt = ""
        switch(opType){
        case .EDIT:
            rightTxt = "保存"
            setDefalutIcon()
            break;
        case .DISPLAY:
            rightTxt = "编辑"
            loadCurKeeper()
            break;
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: rightTxt, style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("rightMenuClick"))
        setTextModel()
        
        showpass.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer.init(target: self, action: Selector.init("setPassModel"))
        showpass.addGestureRecognizer(tapGesture)
        
        scrollview.contentSize = CGSize.init(width: 0, height: (PhoneUtils.screenHeight - 63))
        
        icLogo.layer.cornerRadius = 22.5
        icLogo.layer.masksToBounds = true
        icLogo.userInteractionEnabled = true
        let tagGesture = UITapGestureRecognizer.init(target: self, action: Selector.init("showPick"))
        icLogo.addGestureRecognizer(tagGesture)
    }
    
    func rightMenuClick(){
        switch(opType){
        case .EDIT:
            if(isUpdateKeeper){
                updateKeeper()
            }else{
                saveNewKeeper()
            }
            break;
        case .DISPLAY:
            opType = .EDIT
            isUpdateKeeper = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("rightMenuClick"))
            setTextModel()
            break;
        }
    }
    
    func loadCurKeeper(){
        let keeperList = FMDBHelper.getInstance().queryKeeperById(keeperId!)
        let curKeeper = keeperList.objectAtIndex(0) as! KeeperEntity
        tvName.text = curKeeper.k_name
        tvAcount.text = curKeeper.k_account
        tvPass.text = curKeeper.k_pass
        if(curKeeper.k_logo?.isEmpty == false){
            logo = curKeeper.k_logo!
            let url = NSURL(fileURLWithPath: Constants.logoPath+logo)
            let data = NSData.init(contentsOfURL: url)
            icLogo.image = UIImage.init(data: data!)
        }else{
            if(1 == curKeeper.k_type!){
                icLogo.image = UIImage.init(named: "ic_card")
            }else if(2 == curKeeper.k_type!){
                icLogo.image = UIImage.init(named: "ic_innet")
            }else if(3 == curKeeper.k_type!){
                icLogo.image = UIImage.init(named: "ic_email")
            }else{
                icLogo.image = UIImage.init(named: "ic_card")
            }
        }
    }
    
    func setDefalutIcon(){
        if(1 == keeperType){
            icLogo.image = UIImage.init(named: "ic_card")
        }else if(2 == keeperType){
            icLogo.image = UIImage.init(named: "ic_innet")
        }else if(3 == keeperType){
            icLogo.image = UIImage.init(named: "ic_email")
        }else{
            icLogo.image = UIImage.init(named: "ic_card")
        }
    }
    
    func saveNewKeeper(){
        let name = tvName.text
        let account = tvAcount.text
        var pass = (tvPass.text)! as NSString
        if(name?.isEmpty == true || account?.isEmpty == true || pass.length == 0){
            return
        }
        if(pass.length <= 4){
            var temp = ""
            for(var i = 0 ;i<pass.length;i++){
                temp+="*"
            }
            pass = temp
        }else{
            let location = 0
            let length = pass.length - 4
            let range = NSRange.init(location: location, length: length)
            let temp = pass.substringWithRange(range)
            pass = temp+"****"
        }
        FMDBHelper.getInstance().insertNewKeeper(keeperType!, logo: logo, name: name!, account: account!, pass: pass as String, remarks: "")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func updateKeeper(){
        let name = tvName.text
        let account = tvAcount.text
        var pass = (tvPass.text)! as NSString
        if(name?.isEmpty == true || account?.isEmpty == true || pass.length == 0){
            return
        }
        if(pass.length <= 4){
            var temp = ""
            for(var i = 0 ;i<pass.length;i++){
                temp+="*"
            }
            pass = temp
        }else{
            let location = 0
            let length = pass.length - 4
            let range = NSRange.init(location: location, length: length)
            let temp = pass.substringWithRange(range)
            pass = temp+"****"
        }
        let dy = NSMutableDictionary()
        dy.setValue(logo, forKey: DBConstants.Field_LOGO)
        dy.setValue(name, forKey: DBConstants.Field_NAME)
        dy.setValue(account, forKey: DBConstants.Field_ACCOUNT)
        dy.setValue(pass, forKey: DBConstants.Field_PASS)
        FMDBHelper.getInstance().updateKeeper(keeperId!, dy: dy)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setPassModel(){
        if(opType == .EDIT){
            return
        }
        if(tvPass.secureTextEntry){
            tvPass.secureTextEntry = false
            showpass.image = UIImage(named: "ic_showpass")
        }else{
            tvPass.secureTextEntry = true
            showpass.image = UIImage(named: "ic_keeperpass")
        }
    }
    
    func setTextModel(){
        switch(opType){
        case .EDIT:
            tvName.userInteractionEnabled = true
            tvAcount.userInteractionEnabled = true
            tvPass.userInteractionEnabled = true
            
            tvPass.secureTextEntry = true
            tvName.becomeFirstResponder()//显示输入法
            break;
        case .DISPLAY:
            tvName.userInteractionEnabled = false
            tvAcount.userInteractionEnabled = false
            tvPass.userInteractionEnabled = false
            
            tvName.resignFirstResponder()//隐藏输入法
            break;
        }
    }
    
    func showPick(){
        if(opType == .DISPLAY){
            return
        }
        showPickAction()
    }
    
    override func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        super.imagePickerController(picker, didFinishPickingMediaWithInfo: info)
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            icLogo.contentMode = .ScaleAspectFit
            icLogo.image = pickedImage
            
            let max_id = FMDBHelper.getInstance().queryKeeperMaxId()
            logo = "keeper_\(max_id+1).png"
            FileUtils.writeImageFile(pickedImage, fileFullName: logo)
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
