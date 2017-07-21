//
//  WebServiceManager.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/19/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WebServiceManager: NSObject {
    
    class func loginUser(username: String, password: String,completionHandler:@escaping (Bool, LoginModel, String)->()) {
        
        let url = API.UrlHost+API.UrlLogin
        let param = ["Username":username, "Password":password]
        
        self.fetchData(withPOST: url, parameter: param as [String : AnyObject], completionHandler: { (isSuccess, responseData, error) in
            
            var loginModel = LoginModel(fromDictionary: NSDictionary())
            if isSuccess {
                
                let jsonData = responseData as! NSDictionary
                
                if jsonData["Username"] != nil {
                    // now val is not nil and the Optional has been unwrapped, so use it
                    loginModel = LoginModel(fromDictionary: jsonData)
                    completionHandler(true,  loginModel, "")
                }
                else {
                    completionHandler(false, loginModel,jsonData["reason"] as! String)
                }
            }
            else{
                completionHandler(false, loginModel, error)
            }
        })
    }
    
    class func forgotPassword(email: String,completionHandler:@escaping (Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlForgotPassword
        let param = ["Email":email,]
        
        self.fetchData(withPOST: url, parameter: param as [String : AnyObject], completionHandler: { (isSuccess, responseData, error) in
            
            if isSuccess {
                let jsonData = responseData as! NSDictionary
                let result = jsonData["Result"] as! String
                if result == "sent" {
                    completionHandler(true, result)
                }
                else{
                    completionHandler(false, result)
                }
            }
            else{
                completionHandler(false, error)
            }
        })
    }
    
    class func signup(username:String, password:String, email: String, schoolname:String, avatar: Bool, avatarURl:String, completionHandler:@escaping(Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlSignup
        let params = ["Password":password,
                      "Username":username,
                      "Email":email,
                      "SchoolName":schoolname,
                      "Avatar":avatar ? "true" : "false",
                      "Avatarimageurl":avatarURl]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            if isSuccess {
                let jsonData = responseData as! NSDictionary
                let result = jsonData["Result"] as! String
                if result.lowercased().range(of: SignUp.Success.lowercased()) != nil {
                    completionHandler(true, result)
                }
                else {
                    completionHandler(false, result)
                }
            }
            else {
                completionHandler(false, error)
            }
        })
    }
    
    class func dailyPoints(username:String, completionHandler:@escaping(Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlDailyPoint
        let params = ["Username":username]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            if isSuccess {
                let jsonData = responseData as! [String:Int]
                
                if let result = jsonData["dailypoints"], result >= 0 {
                    completionHandler(true, "\(result)")
                }
                else {
                    completionHandler(false, error)
                }
            }
            else {
                completionHandler(false, error)
            }
        })
    }
    
    class func totalUserPoints(username:String, completionHandler:@escaping(Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlTotalPoint
        let params = ["Username":username]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            if isSuccess {
                let jsonData = responseData as! [String:Int]
                if let result = jsonData["totalpoints"] {
                    completionHandler(true, "\(result)")
                }
                else {
                    completionHandler(false, error)
                }
            }
            else {
                completionHandler(false, error)
            }
        })
    }
    
    class func totalSchoolPoints(schoolName:String, completionHandler:@escaping(Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlTotalSchoolPoint
        let params = ["SchoolName":schoolName]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            if isSuccess {
                let jsonData = responseData as! [String:Int]
                if let result = jsonData["totalpoints"] {
                    completionHandler(true, "\(result)")
                }
                else {
                    completionHandler(false, error)
                }
            }
            else {
                completionHandler(false, error)
            }
        })
    }
    
    class func pointListTable(completionHandler:@escaping(Bool, [PointTable], String)->()) {
        let url = API.UrlHost+API.UrlPointTable
        self.fetchData(withGET: url, completionHandler: {(isSuccess, responseData, error) -> () in
            
            var arrayPoint = [AnyObject]()
            if isSuccess {
                let jsonData = responseData  as! [AnyObject]
                
                for model in jsonData {
                    let pModel = PointTable(fromDictionary: model as! NSDictionary)
                    arrayPoint.append(pModel)
                }
                completionHandler(true, arrayPoint as! [PointTable], "")
            }
            else {
                completionHandler(false, arrayPoint as! [PointTable], error)
            }
        })
    }
    
    class func pointFavoriteGet(username:String, completionHandler:@escaping(Bool, FavoriteGetModel, String)->()) {
        
        let url = API.UrlHost+API.UrlPointFavoriteGet
        let params = ["Username":username]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            
            var favModel = FavoriteGetModel(fromDictionary: NSDictionary())
            if isSuccess {
                let jsonData = responseData  as! NSDictionary
                
                favModel = FavoriteGetModel(fromDictionary: jsonData)
                completionHandler(true, favModel, "")
            }
            else {
                completionHandler(false, favModel, error)
            }
        })
    }
    
    class func pointFavoriteSet(username:String,isFavorite: Bool, task:String, completionHandler:@escaping(Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlPointFavoriteSet
        let params = ["Username":username,
                      "IsFavorite":isFavorite ? 1 : 0,
                      "Task":task] as [String : Any]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            
            if isSuccess {
                let jsonData = responseData  as! NSDictionary
                guard let strResult = jsonData["Result"] else{
                    completionHandler(false, error)
                    return
                }
                
                completionHandler(true, strResult as! String)
            }
            else {
                completionHandler(false, error)
            }
        })
    }
    
    class func pointAddDeeds(username:String, deed:String, date:Date, completionHandler:@escaping(Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlPointAddDeed
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let strDate = dateFormat.string(from: date)
        let params = ["user":username,
                      "deed":deed,
                      "date":strDate]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            
            if isSuccess {
                let jsonData = responseData  as! [String: String]
                completionHandler(true, jsonData["Result"]!)
            }
            else {
                completionHandler(false, error)
            }
        })
    }
    
    class func pointRecentDeeds(username:String, completionHandler:@escaping(Bool, [RecentDeedModel], String)->()) {
        
        let url = API.UrlHost+API.UrlPointRecentDeed
        let params = ["Username":username]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            
            var arrayPoint = [AnyObject]()
            if isSuccess {
                let jsonData = responseData  as! [AnyObject]
                
                for model in jsonData {
                    let rModel = RecentDeedModel(fromDictionary: model as! NSDictionary)
                    arrayPoint.append(rModel)
                }
                completionHandler(true, arrayPoint as! [RecentDeedModel], "")
            }
            else {
                completionHandler(false, arrayPoint as! [RecentDeedModel], error)
            }
        })
    }
    
    class func friendRequestList(username:String, completionHandler:@escaping(Bool, FriendRequestListModel, String)->()) {
        
        let url = API.UrlHost+API.UrlFriendRequestList
        let params = ["Username":username]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            
            var frModel = FriendRequestListModel(fromDictionary: NSDictionary())
            if isSuccess {
                let jsonData = responseData  as! NSDictionary
                frModel = FriendRequestListModel(fromDictionary: jsonData)
                completionHandler(true, frModel, "")
            }
            else {
                completionHandler(false, frModel, error)
            }
        })
    }
    
    class func friendAdd(sender:String, receiver:String, completionHandler:@escaping(Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlFriendAdd
        let params = ["Sender":sender,
                      "Reciever":receiver]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            
            if isSuccess {
                let jsonData = responseData  as! NSDictionary
                guard let strResult = jsonData["Result"] else{
                    completionHandler(false, error)
                    return
                }
                
                completionHandler(true, strResult as! String)
            }
            else {
                completionHandler(false, error)
            }
        })
    }
    
    class func friendStatusResponse(sender:String, receiver:String, status:Int, completionHandler:@escaping(Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlFriendStatus
        let params = ["Sender":receiver,
                      "Reciever":sender,
                      "Status":status] as [String : Any]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            
            if isSuccess {
                let jsonData = responseData  as! NSDictionary
                guard let strResult = jsonData["Result"] else{
                    completionHandler(false, error)
                    return
                }
                
                completionHandler(true, strResult as! String)
            }
            else {
                completionHandler(false, error)
            }
        })
    }
    
    class func friendList(username:String, completionHandler:@escaping(Bool, FriendListModel, String)->()) {
        
        let url = API.UrlHost+API.UrlFriendList
        let params = ["Username":username]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            
            var frListModel = FriendListModel(fromDictionary: NSDictionary())
            if isSuccess {
                let jsonData = responseData  as! NSDictionary
                frListModel = FriendListModel(fromDictionary: jsonData)
                completionHandler(true, frListModel, "")
            }
            else {
                completionHandler(false,frListModel, error)
            }
        })
    }
    
    class func chatSend(sender:String, reciever:String, message:String, date:String, completionHandler:@escaping(Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlChatSend
        let params = ["Sender":sender,
                      "Reciever":reciever,
                      "Message":message,
                      "DateAndTime": date]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            
            if isSuccess {
                let jsonData = responseData  as! [String:String]
                guard let strResult = jsonData["Result"], strResult.lowercased() == "Message sent.".lowercased() else{
                    completionHandler(false, error)
                    return
                }
                
                completionHandler(true, strResult)
            }
            else {
                completionHandler(false, error)
            }
        })
    }
    
    class func chatGet(sender:String, reciever:String, date:String, completionHandler:@escaping(Bool, ChatGetMessageModel, String)->()) {
        
        let url = API.UrlHost+API.UrlChatGet
        let params = ["Sender":sender,
                      "Reciever":reciever,
                      "DateAndTime":date]
        
        self.fetchData(withPOST: url, parameter: params as [String : AnyObject], completionHandler: {(isSuccess, responseData, error) -> () in
            
            var chatModel = ChatGetMessageModel(fromDictionary: NSDictionary())
            if isSuccess {
                let jsonData = responseData  as! NSDictionary
                chatModel = ChatGetMessageModel(fromDictionary: jsonData)
                completionHandler(true, chatModel, "")
            }
            else {
                completionHandler(false,chatModel, error)
            }
        })
    }
    
    class func changePassword(username: String, password: String,completionHandler:@escaping (Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlChangePassword
        let param = ["Username":username, "Password":password]
        
        self.fetchData(withPOST: url, parameter: param as [String : AnyObject], completionHandler: { (isSuccess, responseData, error) in
            
            if isSuccess {
                let jsonData = responseData  as! [String:String]
                guard let strResult = jsonData["Result"] else{
                    completionHandler(false, error)
                    return
                }
                
                completionHandler(true, strResult)
            }
            else {
                completionHandler(false, error)
            }
        })
    }
    
    class func progressPoint(username: String, year: String, completionHandler:@escaping (Bool, ProgressModel,String)->()) {
        
        let url = API.UrlHost+API.UrlProgress
        let param = ["Username":username,
                     "Year":year]
        
        self.fetchData(withPOST: url, parameter: param as [String : AnyObject], completionHandler: { (isSuccess, responseData, error) in
            
            var progressModel = ProgressModel(fromDictionary: NSDictionary())
            if isSuccess {
                let jsonData = responseData as! NSDictionary
                // now val is not nil and the Optional has been unwrapped, so use it
                progressModel = ProgressModel(fromDictionary: jsonData)
                completionHandler(true,  progressModel, "")
            }
            else{
                completionHandler(false, progressModel, error)
            }
        })
    }
    
    class func changeTouchID(username: String, isTouchEnable: Bool,completionHandler:@escaping (Bool, String)->()) {
        
        let url = API.UrlHost+API.UrlTouchID
        let param = ["Username":username, "TouchIdOn":isTouchEnable] as [String : Any]
        
        self.fetchData(withPOST: url, parameter: param as [String : AnyObject], completionHandler: { (isSuccess, responseData, error) in
            
            if isSuccess {
                let jsonData = responseData  as! [String:String]
                guard let strResult = jsonData["Result"] else{
                    completionHandler(false, error)
                    return
                }
                
                completionHandler(true, strResult)
            }
            else {
                completionHandler(false, error)
            }
        })
    }
    
    class func fetchData(withPOST url:String, parameter param:[String:AnyObject], completionHandler:@escaping (Bool, AnyObject, String)->()) {
        
        var header: HTTPHeaders = ["Content-Type":"application/json"]
        header["Accept"] = "application/json"
        
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                
                if (response.result.value != nil) {
                    completionHandler(true,  response.result.value as AnyObject, "")
                }
                else{
                    completionHandler(false, "" as AnyObject, (response.error?.localizedDescription)!)
                }
        }
    }
    
    class func fetchData(withGET url:String, completionHandler:@escaping (Bool, AnyObject, String)->()) {
        
        var header: HTTPHeaders = ["Content-Type":"application/json"]
        header["Accept"] = "application/json"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                
                if (response.result.value != nil) {
                    completionHandler(true,  response.result.value as AnyObject, "")
                }
                else{
                    completionHandler(false, "" as AnyObject, (response.error?.localizedDescription)!)
                }
        }
    }
}
