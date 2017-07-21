//
//	RootClass.swift
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation


class RecentDeedModel : NSObject, NSCoding{

	var date : String!
    var deed : String!
    
    
    public func encode(with aCoder: NSCoder) {
        if date != nil{
            aCoder.encode(date, forKey: "date")
        }
        if deed != nil{
            aCoder.encode(deed, forKey: "deed")
        }
    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		date = dictionary["date"] as? String
		deed = dictionary["deed"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if date != nil{
			dictionary["date"] = date
		}
		if deed != nil{
			dictionary["deed"] = deed
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         date = aDecoder.decodeObject(forKey: "date") as? String
         deed = aDecoder.decodeObject(forKey: "deed") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if date != nil{
			aCoder.encode(date, forKey: "date")
		}
		if deed != nil{
			aCoder.encode(deed, forKey: "deed")
		}

	}

}
