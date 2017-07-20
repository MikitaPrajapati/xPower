//
//  ImageViewExtension.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/19/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func loadFromFile(photo:String)
    {
        let img=UIImage(named:photo)
        self.image=img
        self.alpha=0.4
    }
}
