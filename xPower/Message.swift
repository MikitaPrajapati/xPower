//
//	Message.swift
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//	Model file Generated using:
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation


class Message : NSObject, NSCoding{
    
    var dateAndTime : String!
    var message : String!
    var reciever : String!
    var sender : String!
    
    public func encode(with aCoder: NSCoder) {
        if dateAndTime != nil{
            aCoder.encode(dateAndTime, forKey: "DateAndTime")
        }
        if message != nil{
            aCoder.encode(message, forKey: "Message")
        }
        if reciever != nil{
            aCoder.encode(reciever, forKey: "Reciever")
        }
        if sender != nil{
            aCoder.encode(sender, forKey: "Sender")
        }
    }
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        dateAndTime = dictionary["DateAndTime"] as? String
        message = dictionary["Message"] as? String
        reciever = dictionary["Reciever"] as? String
        sender = dictionary["Sender"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if dateAndTime != nil{
            dictionary["DateAndTime"] = dateAndTime
        }
        if message != nil{
            dictionary["Message"] = message
        }
        if reciever != nil{
            dictionary["Reciever"] = reciever
        }
        if sender != nil{
            dictionary["Sender"] = sender
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        dateAndTime = aDecoder.decodeObject(forKey: "DateAndTime") as? String
        message = aDecoder.decodeObject(forKey: "Message") as? String
        reciever = aDecoder.decodeObject(forKey: "Reciever") as? String
        sender = aDecoder.decodeObject(forKey: "Sender") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if dateAndTime != nil{
            aCoder.encode(dateAndTime, forKey: "DateAndTime")
        }
        if message != nil{
            aCoder.encode(message, forKey: "Message")
        }
        if reciever != nil{
            aCoder.encode(reciever, forKey: "Reciever")
        }
        if sender != nil{
            aCoder.encode(sender, forKey: "Sender")
        }
        
    }
    
}
