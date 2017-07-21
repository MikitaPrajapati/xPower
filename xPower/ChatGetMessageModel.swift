//
//	RootClass.swift
//
//	Created by Mikita Gandhi on 7/20/17.
//	Copyright © 2017 Software Merchant. All rights reserved.
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation


class ChatGetMessageModel : NSObject, NSCoding{

	var count : Int!
	var messages : [Message]!

    public func encode(with aCoder: NSCoder) {
        if count != nil{
            aCoder.encode(count, forKey: "Count")
        }
        if messages != nil{
            aCoder.encode(messages, forKey: "Messages")
        }
    }
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		count = dictionary["Count"] as? Int
		messages = [Message]()
		if let messagesArray = dictionary["Messages"] as? [NSDictionary]{
			for dic in messagesArray{
				let value = Message(fromDictionary: dic)
				messages.append(value)
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
		if messages != nil{
			var dictionaryElements = [NSDictionary]()
			for messagesElement in messages {
				dictionaryElements.append(messagesElement.toDictionary())
			}
			dictionary["Messages"] = dictionaryElements
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
         messages = aDecoder.decodeObject(forKey: "Messages") as? [Message]

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
		if messages != nil{
			aCoder.encode(messages, forKey: "Messages")
		}

	}

}
