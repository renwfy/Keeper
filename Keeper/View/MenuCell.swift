//
//  MenuCell.swift
//  Keeper
//
//  Created by LSD on 16/2/2.
//  Copyright © 2016年 renwfy.fr. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var t_logo: UIImageView!
    @IBOutlet weak var t_name: UILabel!
    @IBOutlet weak var t_select: UIImageView!
    @IBOutlet weak var line: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        t_logo.layer.cornerRadius = 15
        t_logo.layer.masksToBounds = true
    }

    override func setHighlighted(highlighted: Bool, animated: Bool) {
        if(highlighted){
            self.backgroundColor = Colors.lightGray
        }else{
            self.backgroundColor = UIColor.whiteColor()
        }
    }
    
}
