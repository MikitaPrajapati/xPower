//
//  SettingViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import MBProgressHUD
import MessageUI

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tblSetting: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "settings")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
        
        self.tblSetting.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func valuechange_TouchID(_ sender: Any) {
        print("Change")
        let touch:UISwitch = sender as! UISwitch
        let status:Bool = touch.isOn
        
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.changeTouchID(username: username, isTouchEnable: status) { (isSuccess, message) in
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                if isSuccess{
                    UserDefaults.standard.set(status, forKey: AppDefault.TouchID)
                    UserDefaults.standard.synchronize()
                }
                let alert = UIAlertController(title: "XPower", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChangePassword")! as UITableViewCell
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Report")! as UITableViewCell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TouchID")! as UITableViewCell
            let touch = cell.contentView.viewWithTag(101) as! UISwitch
            touch.isOn = UserDefaults.standard.bool(forKey: AppDefault.TouchID)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1{
            if MFMailComposeViewController.canSendMail(){
                let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
                
                let mailComposerVC = MFMailComposeViewController()
                mailComposerVC.mailComposeDelegate = self
                mailComposerVC.setToRecipients(["xpower3578@gmail.com"])
                mailComposerVC.setSubject("Concerns of \(username)")
                self.present(mailComposerVC, animated: true, completion: nil)
            }
            else{
                self.showSendMailErrorAlert()
            }
        }
    }
    
    func showSendMailErrorAlert() {
        let alert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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
