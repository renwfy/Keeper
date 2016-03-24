//
//  NewTypeViewController.swift
//  Keeper
//
//  Created by LSD on 16/2/3.
//  Copyright © 2016年 renwfy.fr. All rights reserved.
//

import UIKit

class NewTypeViewController: BaseViewController {
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var icLogo: UIImageView!
    @IBOutlet weak var tvType: UITextField!
    
    var logo = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "添加新分类"
        
        //title右边菜单
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: Selector.init("saveType"))
        
        scrollview.contentSize = CGSize.init(width: 0, height: (PhoneUtils.screenHeight-63))
        
        icLogo.layer.cornerRadius = 22.5
        icLogo.layer.masksToBounds = true
        icLogo.userInteractionEnabled = true
        let tagGesture = UITapGestureRecognizer.init(target: self, action: Selector.init("showPickAction"))
        icLogo.addGestureRecognizer(tagGesture)
    }
    
    func saveType(){
        let text = tvType.text
        if(text?.isEmpty == true ||  nil == text){
            return
        }
        FMDBHelper.getInstance().insertNewType(text!, logo: logo)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    override func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       super.imagePickerController(picker, didFinishPickingMediaWithInfo: info)
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            icLogo.contentMode = .ScaleAspectFit
            icLogo.image = pickedImage
            
            let max_id = FMDBHelper.getInstance().queryTypeMaxId()
            logo = "type_\(max_id+1).png"
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
