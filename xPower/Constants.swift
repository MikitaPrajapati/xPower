//
//  Constants.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/19/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit

struct AppDefault {
    static let AppName = "XPower"
    static let SelectSchool = "Select School"
    static let KeepLogIn = "keepLogIn"
    static let Username = "Username"
    static let SchoolName = "SchoolName"
    static let TouchID = "IsTouchEnable"
    static let RequestAppear = "IsRequestAlertShown"
}

struct Menu {
    static let Home = "Home"
    static let Points = "Points"
    static let Score = "Score"
    static let Friends = "Friends"
    static let Settings = "Settings"
    static let Logout = "Logout"
}

struct API {
    static let UrlHost = "http://www.consoaring.com"
    static let UrlLogin = "/UserService.svc/userauthentication"
    static let UrlForgotPassword = "/UserService.svc/resetpassword"
    static let UrlSignup = "/UserService.svc/CreateUserAccount"
    static let UrlChangePassword = "/UserService.svc/changepassword"
    static let UrlTouchID = "/UserService.svc/toggletouchid"
    
    static let UrlDailyPoint = "/PointService.svc/dailypoints"
    static let UrlTotalSchoolPoint = "/PointService.svc/totalschoolpoints"
    static let UrlPointList = "/PointService.svc/pointslistarray"
    static let UrlPointTable = "/PointService.svc/pointstable"
    static let UrlPointFavoriteGet = "/PointService.svc/getfavoritetasks"
    static let UrlPointFavoriteSet = "/PointService.svc/setfavoritetask"
    static let UrlPointRecentDeed = "/PointService.svc/getrecentdeeds"
    static let UrlPointAddDeed = "/PointService.svc/adddeeds"
    static let UrlProgress = "/PointService.svc/getuserprogress"
    static let UrlTotalPoint = "/PointService.svc/totalpoints"
    
    static let UrlFriendRequestList = "/UserService.svc/getfriendrequests"
    static let UrlFriendAdd = "/UserService.svc/addfriendrequest"
    static let UrlFriendStatus = "/UserService.svc/respondfriendrequest"
    static let UrlFriendList = "/UserService.svc/getfriendslist"
    
    static let UrlChatSend = "/ChatService.svc/sendmessage"
    static let UrlChatGet = "/ChatService.svc/getmessages"
}

struct SecureKey {
    static let Key = "secret0key000000"
    static let Iv = "0000000000000000"
}

struct School {
    static let HaverfordName = "Haverford"
    static let AgnesIrwinName = "Agnes Irwin"
    
    static let Param_AgnesIrwinSchool = "Agnes Irwin School"
    
    static let HaverfordEmail = "@haverford.org"
    static let AgnesIrwinEmail = "@agnesirwin.org"
}

struct SignUp {
    static let Success = "Created User Account for user"
}

struct ProgilePic {
    static let width = 200.0
}
