//
//  PointTableViewCell.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit

protocol PointTableCellDelegate {
    func pointDeedAdded(at: Int)
    func favoriteAdded(at: Int, isFav: Bool)
}

class PointTableViewCell: UITableViewCell {

    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var constraint_BtnWidth: NSLayoutConstraint!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var constraint_BtnFav_width: NSLayoutConstraint!
    var isFavorite: Bool!
    
    var delegate:PointTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressAddBtn(_ sender: Any) {
        delegate?.pointDeedAdded(at: self.tag)
    }
    
    @IBAction func pressFavBtn(_ sender: Any) {
        delegate?.favoriteAdded(at: self.tag, isFav: isFavorite)
    }
}
