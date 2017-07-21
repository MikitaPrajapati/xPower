//
//	PointTable.swift
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation


class PointTable : NSObject, NSCoding{
    public func encode(with aCoder: NSCoder) {
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "Description")
        }
        if point != nil{
            aCoder.encode(point, forKey: "Point")
        }
    }


	var descriptionField : String!
	var point : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		descriptionField = dictionary["Description"] as? String
		point = dictionary["Point"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if descriptionField != nil{
			dictionary["Description"] = descriptionField
		}
		if point != nil{
			dictionary["Point"] = point
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         descriptionField = aDecoder.decodeObject(forKey: "Description") as? String
         point = aDecoder.decodeObject(forKey: "Point") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "Description")
		}
		if point != nil{
			aCoder.encode(point, forKey: "Point")
		}

	}

}
