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


class FavoriteGetModel : NSObject, NSCoding{

	var count : Int!
	var tasksList : [TasksList]!
	var username : String!

    public func encode(with aCoder: NSCoder) {
        if count != nil{
            aCoder.encode(count, forKey: "Count")
        }
        if tasksList != nil{
            aCoder.encode(tasksList, forKey: "TasksList")
        }
        if username != nil{
            aCoder.encode(username, forKey: "Username")
        }
    }
    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		count = dictionary["Count"] as? Int
		tasksList = [TasksList]()
		if let tasksListArray = dictionary["TasksList"] as? [NSDictionary]{
			for dic in tasksListArray{
				let value = TasksList(fromDictionary: dic)
				tasksList.append(value)
			}
		}
		username = dictionary["Username"] as? String
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
		if tasksList != nil{
			var dictionaryElements = [NSDictionary]()
			for tasksListElement in tasksList {
				dictionaryElements.append(tasksListElement.toDictionary())
			}
			dictionary["TasksList"] = dictionaryElements
		}
		if username != nil{
			dictionary["Username"] = username
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
         tasksList = aDecoder.decodeObject(forKey: "TasksList") as? [TasksList]
         username = aDecoder.decodeObject(forKey: "Username") as? String

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
		if tasksList != nil{
			aCoder.encode(tasksList, forKey: "TasksList")
		}
		if username != nil{
			aCoder.encode(username, forKey: "Username")
		}

	}

}
