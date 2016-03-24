//
//  KeeperCell.swift
//  Keeper
//
//  Created by LSD on 16/2/3.
//  Copyright © 2016年 renwfy.fr. All rights reserved.
//

import UIKit

class KeeperCell: UITableViewCell {
    internal enum ShowStyle : Int {
        case IMG
        case TXT
    }
    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txt: UILabel!
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvContent: UILabel!
    @IBOutlet weak var line: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bg.layer.cornerRadius = 20
        bg.layer.masksToBounds = true
        img.layer.cornerRadius = 20
        img.layer.masksToBounds = true
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        if(highlighted){
            self.backgroundColor = Colors.lightGray
        }else{
            self.backgroundColor = UIColor.whiteColor()
        }
    }
    
    func setShowStyle(position:Int , style:ShowStyle){
        switch style{
        case .IMG:
            bg.hidden = true
            txt.hidden = true
            img.hidden = false
            break
        case .TXT:
            bg.hidden = false
            let offset = position % 4
            if(0 == offset){
                bg.backgroundColor = UIColor.redColor()
            }
            if(1 == offset){
                bg.backgroundColor = UIColor.blueColor()
            }
            if(2 == offset){
                bg.backgroundColor = UIColor.greenColor()
            }
            if(3 == offset){
                bg.backgroundColor = UIColor.orangeColor()
            }

            txt.hidden = false
            img.hidden = true
            break
        }
        
    }
    
}
