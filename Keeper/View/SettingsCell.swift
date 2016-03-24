//
//  SettingsCell.swift
//  Keeper
//
//  Created by LSD on 16/3/24.
//  Copyright © 2016年 renwfy.fr. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var tvText: UILabel!
    @IBOutlet weak var tvSubText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        ivIcon.layer.cornerRadius = 5
        ivIcon.layer.masksToBounds = true

    }

    override func setHighlighted(highlighted: Bool, animated: Bool) {
        //设置按下效果
        if(highlighted){
            self.backgroundColor = Colors.lightGray
        }else{
            self.backgroundColor = UIColor.whiteColor()
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
