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


class ProgressModel : NSObject, NSCoding{

	var apr : Int!
	var aug : Int!
	var dec : Int!
	var error : Int!
	var feb : Int!
	var jan : Int!
	var jul : Int!
	var jun : Int!
	var mar : Int!
	var maxPoint : Int!
	var may : Int!
	var nov : Int!
	var oct : Int!
	var sep : Int!

    public func encode(with aCoder: NSCoder) {
        if apr != nil{
            aCoder.encode(apr, forKey: "Apr")
        }
        if aug != nil{
            aCoder.encode(aug, forKey: "Aug")
        }
        if dec != nil{
            aCoder.encode(dec, forKey: "Dec")
        }
        if error != nil{
            aCoder.encode(error, forKey: "Error")
        }
        if feb != nil{
            aCoder.encode(feb, forKey: "Feb")
        }
        if jan != nil{
            aCoder.encode(jan, forKey: "Jan")
        }
        if jul != nil{
            aCoder.encode(jul, forKey: "Jul")
        }
        if jun != nil{
            aCoder.encode(jun, forKey: "Jun")
        }
        if mar != nil{
            aCoder.encode(mar, forKey: "Mar")
        }
        if maxPoint != nil{
            aCoder.encode(maxPoint, forKey: "MaxPoint")
        }
        if may != nil{
            aCoder.encode(may, forKey: "May")
        }
        if nov != nil{
            aCoder.encode(nov, forKey: "Nov")
        }
        if oct != nil{
            aCoder.encode(oct, forKey: "Oct")
        }
        if sep != nil{
            aCoder.encode(sep, forKey: "Sep")
        }
    }
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		apr = dictionary["Apr"] as? Int
		aug = dictionary["Aug"] as? Int
		dec = dictionary["Dec"] as? Int
		error = dictionary["Error"] as? Int
		feb = dictionary["Feb"] as? Int
		jan = dictionary["Jan"] as? Int
		jul = dictionary["Jul"] as? Int
		jun = dictionary["Jun"] as? Int
		mar = dictionary["Mar"] as? Int
		maxPoint = dictionary["MaxPoint"] as? Int
		may = dictionary["May"] as? Int
		nov = dictionary["Nov"] as? Int
		oct = dictionary["Oct"] as? Int
		sep = dictionary["Sep"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if apr != nil{
			dictionary["Apr"] = apr
		}
		if aug != nil{
			dictionary["Aug"] = aug
		}
		if dec != nil{
			dictionary["Dec"] = dec
		}
		if error != nil{
			dictionary["Error"] = error
		}
		if feb != nil{
			dictionary["Feb"] = feb
		}
		if jan != nil{
			dictionary["Jan"] = jan
		}
		if jul != nil{
			dictionary["Jul"] = jul
		}
		if jun != nil{
			dictionary["Jun"] = jun
		}
		if mar != nil{
			dictionary["Mar"] = mar
		}
		if maxPoint != nil{
			dictionary["MaxPoint"] = maxPoint
		}
		if may != nil{
			dictionary["May"] = may
		}
		if nov != nil{
			dictionary["Nov"] = nov
		}
		if oct != nil{
			dictionary["Oct"] = oct
		}
		if sep != nil{
			dictionary["Sep"] = sep
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         apr = aDecoder.decodeObject(forKey: "Apr") as? Int
         aug = aDecoder.decodeObject(forKey: "Aug") as? Int
         dec = aDecoder.decodeObject(forKey: "Dec") as? Int
         error = aDecoder.decodeObject(forKey: "Error") as? Int
         feb = aDecoder.decodeObject(forKey: "Feb") as? Int
         jan = aDecoder.decodeObject(forKey: "Jan") as? Int
         jul = aDecoder.decodeObject(forKey: "Jul") as? Int
         jun = aDecoder.decodeObject(forKey: "Jun") as? Int
         mar = aDecoder.decodeObject(forKey: "Mar") as? Int
         maxPoint = aDecoder.decodeObject(forKey: "MaxPoint") as? Int
         may = aDecoder.decodeObject(forKey: "May") as? Int
         nov = aDecoder.decodeObject(forKey: "Nov") as? Int
         oct = aDecoder.decodeObject(forKey: "Oct") as? Int
         sep = aDecoder.decodeObject(forKey: "Sep") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if apr != nil{
			aCoder.encode(apr, forKey: "Apr")
		}
		if aug != nil{
			aCoder.encode(aug, forKey: "Aug")
		}
		if dec != nil{
			aCoder.encode(dec, forKey: "Dec")
		}
		if error != nil{
			aCoder.encode(error, forKey: "Error")
		}
		if feb != nil{
			aCoder.encode(feb, forKey: "Feb")
		}
		if jan != nil{
			aCoder.encode(jan, forKey: "Jan")
		}
		if jul != nil{
			aCoder.encode(jul, forKey: "Jul")
		}
		if jun != nil{
			aCoder.encode(jun, forKey: "Jun")
		}
		if mar != nil{
			aCoder.encode(mar, forKey: "Mar")
		}
		if maxPoint != nil{
			aCoder.encode(maxPoint, forKey: "MaxPoint")
		}
		if may != nil{
			aCoder.encode(may, forKey: "May")
		}
		if nov != nil{
			aCoder.encode(nov, forKey: "Nov")
		}
		if oct != nil{
			aCoder.encode(oct, forKey: "Oct")
		}
		if sep != nil{
			aCoder.encode(sep, forKey: "Sep")
		}

	}

}
