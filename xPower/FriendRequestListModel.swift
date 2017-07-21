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


class FriendRequestListModel : NSObject, NSCoding{

	var count : Int!
	var requests : [Request]!

    public func encode(with aCoder: NSCoder) {
        if count != nil{
            aCoder.encode(count, forKey: "Count")
        }
        if requests != nil{
            aCoder.encode(requests, forKey: "Requests")
        }
    }
    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		count = dictionary["Count"] as? Int
		requests = [Request]()
		if let requestsArray = dictionary["Requests"] as? [NSDictionary]{
			for dic in requestsArray{
				let value = Request(fromDictionary: dic)
				requests.append(value)
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
		if requests != nil{
			var dictionaryElements = [NSDictionary]()
			for requestsElement in requests {
				dictionaryElements.append(requestsElement.toDictionary())
			}
			dictionary["Requests"] = dictionaryElements
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
         requests = aDecoder.decodeObject(forKey: "Requests") as? [Request]

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
		if requests != nil{
			aCoder.encode(requests, forKey: "Requests")
		}

	}

}
