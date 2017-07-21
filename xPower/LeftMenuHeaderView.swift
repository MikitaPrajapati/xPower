//
//  LeftMenuHeaderView.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit

@objc protocol leftMenuHeaderDelegate: NSObjectProtocol {
    @objc optional func changeAvatar()
}

class LeftMenuHeaderView: UITableViewCell {

    @IBOutlet weak var imgvAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    
    var delegate: leftMenuHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAvatar(_:)))
        self.imgvAvatar.addGestureRecognizer(tapGesture)
        
        self.imgvAvatar.layer.borderWidth = 2
        self.imgvAvatar.layer.cornerRadius = self.imgvAvatar.frame.height / 2
        self.imgvAvatar.layer.borderColor = UIColor.black.cgColor
        self.imgvAvatar.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func tapAvatar(_ sender: UITapGestureRecognizer) {
        if delegate != nil && delegate!.responds(to: #selector(leftMenuHeaderDelegate.changeAvatar)){
            delegate?.changeAvatar!()
        }
    }
}
