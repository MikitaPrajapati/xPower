//
//  LoginModel.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/19/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import Foundation


class LoginModel : NSObject, NSCoding{
    public func encode(with aCoder: NSCoder) {
        if avatar != nil{
            aCoder.encode(avatar, forKey: "Avatar")
        }
        if avatarimageurl != nil{
            aCoder.encode(avatarimageurl, forKey: "Avatarimageurl")
        }
        if email != nil{
            aCoder.encode(email, forKey: "Email")
        }
        if password != nil{
            aCoder.encode(password, forKey: "Password")
        }
        if schoolName != nil{
            aCoder.encode(schoolName, forKey: "SchoolName")
        }
        if touchIdOn != nil{
            aCoder.encode(touchIdOn, forKey: "TouchIdOn")
        }
        if username != nil{
            aCoder.encode(username, forKey: "Username")
        }
    }
    
    
    
    var avatar : Bool!
    var avatarimageurl : String!
    var email : String!
    var password : String!
    var schoolName : String!
    var touchIdOn : Bool!
    var username : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        avatar = dictionary["Avatar"] as? Bool
        avatarimageurl = dictionary["Avatarimageurl"] as? String
        email = dictionary["Email"] as? String
        password = dictionary["Password"] as? String
        schoolName = dictionary["SchoolName"] as? String
        touchIdOn = dictionary["TouchIdOn"] as? Bool
        username = dictionary["Username"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if avatar != nil{
            dictionary["Avatar"] = avatar
        }
        if avatarimageurl != nil{
            dictionary["Avatarimageurl"] = avatarimageurl
        }
        if email != nil{
            dictionary["Email"] = email
        }
        if password != nil{
            dictionary["Password"] = password
        }
        if schoolName != nil{
            dictionary["SchoolName"] = schoolName
        }
        if touchIdOn != nil{
            dictionary["TouchIdOn"] = touchIdOn
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
        avatar = aDecoder.decodeObject(forKey: "Avatar") as? Bool
        avatarimageurl = aDecoder.decodeObject(forKey: "Avatarimageurl") as? String
        email = aDecoder.decodeObject(forKey: "Email") as? String
        password = aDecoder.decodeObject(forKey: "Password") as? String
        schoolName = aDecoder.decodeObject(forKey: "SchoolName") as? String
        touchIdOn = aDecoder.decodeObject(forKey: "TouchIdOn") as? Bool
        username = aDecoder.decodeObject(forKey: "Username") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if avatar != nil{
            aCoder.encode(avatar, forKey: "Avatar")
        }
        if avatarimageurl != nil{
            aCoder.encode(avatarimageurl, forKey: "Avatarimageurl")
        }
        if email != nil{
            aCoder.encode(email, forKey: "Email")
        }
        if password != nil{
            aCoder.encode(password, forKey: "Password")
        }
        if schoolName != nil{
            aCoder.encode(schoolName, forKey: "SchoolName")
        }
        if touchIdOn != nil{
            aCoder.encode(touchIdOn, forKey: "TouchIdOn")
        }
        if username != nil{
            aCoder.encode(username, forKey: "Username")
        }
        
    }
    
}
