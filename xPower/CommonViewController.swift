//
//  CommonViewController.swift
//  XPower
//
//  Created by Software Merchant on 1/24/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func loadLoginView() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeController: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigation = UINavigationController(rootViewController:homeController)
        appDelegate.window?.rootViewController = navigation
    }

    class func loadHomeView() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = SVMenuOptionManager.sharedInstance.slidingPanel
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func resetFriendRequest() {
        
        let delegate = AppDelegate.getDelegate()
        delegate.isRequestAppear = false
        
        let vc:LeftMenuTableViewController = SVMenuOptionManager.sharedInstance.slidingPanel.leftPanel as! LeftMenuTableViewController
        UIApplication.shared.applicationIconBadgeNumber = 0
        vc.arrayMenu[3] = Menu.Friends
        vc.tableView.reloadData()
    }
    
    class func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
