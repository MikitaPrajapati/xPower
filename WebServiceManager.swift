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

class WebServiceManager:NSObject{
    
    class func loginUser(username:String,password:String,completionHandler:@escaping(Bool, LoginModel,String)->()) {
        let url = API.UrlHost + API.UrlLogin
        let param = ["Username":username, "Password":password]
        
        self.fetchData(withPOST:url,parameter:param as [String : AnyObject], completionHandler: {(isSucess,responseData,error) in
            var loginModel = LoginModel(fromDictionary: NSDictionary())
            if isSucess{
                let jsonData=responseData as! NSDictionary
                
                if jsonData["Username"] != nil {
                    loginModel=LoginModel(fromDictionary:jsonData)
                    completionHandler(true, loginModel,"")
                }
                else
                {
                    completionHandler(false,loginModel,jsonData["reason"] as! String)
                }
            }
            else{
                completionHandler(false,loginModel,error)
            }
        })
    }
    
    class func forgotPassword(email: String,completionHandler:@escaping(Bool,String)->()){
        let url=API.UrlHost + API.UrlForgotPassword
        let param=["Email":email,]
        
        self.fetchData(withPOST: url, parameter: param as [String: AnyObject], completionHandler: {(isSuccess, responseData, error) in
            if isSuccess{
                let jsonData=responseData as! NSDictionary
                let result=jsonData["Result"] as! String
                if(result=="sent")
                {
                    completionHandler(true,result)
                }
                else
                {
                    completionHandler(false,result)
                }
            }
            else{
                completionHandler(false,error)
            }
        })
    }
        
    class func fetchData(withPOST url:String, parameter param:[String:AnyObject], completionHandler:@escaping(Bool,AnyObject,String)->()){
        var header: HTTPHeaders = ["Content-Type":"application/json"]
        header["Accept"]="application/json"
            
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
        .responseJSON { (response) in
        if (response.result.value != nil)
        {
            completionHandler(true, response.result.value as AnyObject,"")
        }
        else
        {
            completionHandler(false,"" as AnyObject,(response.error?.localizedDescription)!)
        }}
    }
}
