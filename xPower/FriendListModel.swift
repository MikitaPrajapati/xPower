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


class FriendListModel : NSObject, NSCoding{

	var count : Int!
	var friends : [Friend]!

    public func encode(with aCoder: NSCoder) {
        if count != nil{
            aCoder.encode(count, forKey: "Count")
        }
        if friends != nil{
            aCoder.encode(friends, forKey: "Friends")
        }
    }
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		count = dictionary["Count"] as? Int
		friends = [Friend]()
		if let friendsArray = dictionary["Friends"] as? [NSDictionary]{
			for dic in friendsArray{
				let value = Friend(fromDictionary: dic)
				friends.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if count != nil{
			dictionary["Count"] = count
		}
		if friends != nil{
			var dictionaryElements = [NSDictionary]()
			for friendsElement in friends {
				dictionaryElements.append(friendsElement.toDictionary())
			}
			dictionary["Friends"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         count = aDecoder.decodeObject(forKey: "Count") as? Int
         friends = aDecoder.decodeObject(forKey: "Friends") as? [Friend]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if count != nil{
			aCoder.encode(count, forKey: "Count")
		}
		if friends != nil{
			aCoder.encode(friends, forKey: "Friends")
		}

	}

}
