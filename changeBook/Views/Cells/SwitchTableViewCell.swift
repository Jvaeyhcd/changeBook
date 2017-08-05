//
//  SwitchTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 05/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdSwitchTableViewCell = "SwitchTableViewCell"

class SwitchTableViewCell: UITableViewCell {
    
    var switchBtnBlock: ((Bool)->())!
    
    private lazy var switchBtn: UISwitch = {
        let switchBtn = UISwitch.init(frame: .zero)
        return switchBtn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.textColor = UIColor(hex: 0x555555)
        self.textLabel?.font = UIFont.systemFont(ofSize: 16)
        self.selectionStyle = .none
        self.accessoryView = self.switchBtn
        self.switchBtn.addTarget(self, action: #selector(switchBtnClicked), for: .touchUpInside)
    }
    
    @objc private func switchBtnClicked() {
        if nil != self.switchBtnBlock {
            self.switchBtnBlock(self.switchBtn.isOn)
        }
    }
    
    func setOn(on: Int) {
        if 0 == on {
            self.switchBtn.isOn = false
        } else if 1 == on {
            self.switchBtn.isOn = true
        }
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 56)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
