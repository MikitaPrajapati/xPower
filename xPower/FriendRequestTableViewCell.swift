//
//  FriendRequestTableViewCell.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit

protocol FriendRequestDelegate {
    func requestAccept(at: Int)
    func requestReject(at: Int)
}

class FriendRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    
    var delegate:FriendRequestDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func pressAcceptBtn(_ sender: Any) {
        self.delegate?.requestAccept(at: self.tag)
    }
    
    @IBAction func pressRejectBtn(_ sender: Any) {
        self.delegate?.requestReject(at: self.tag)
    }
}
