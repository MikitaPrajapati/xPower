//
//  ChangePasswordViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import MBProgressHUD

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "changePassword")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressChangePassword(_ sender: Any) {
        
        let oldPass = self.txtOldPassword.text!
        let newPass = self.txtNewPassword.text!
        let confirmPass = self.txtConfirmPassword.text!
        
        let keyWrapper = KeychainWrapper()
        let oldp:String = keyWrapper.myObject(forKey: kSecValueData) as! String

        if (oldPass.characters.count <= 0 || newPass.characters.count <= 0 || confirmPass.characters.count <= 0){
            showAlert("XPower", message: "Please enter all details")
            return
        }
        else if oldPass != oldp {
            showAlert("XPower", message: "Please enter correct old password")
            return
        }
        else if newPass != confirmPass{
            showAlert("XPower", message: "Please confirm the password")
            return
        }
        
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.changePassword(username: username, password: txtNewPassword.text!) { (isSuccess, message) in
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                if isSuccess {
                    let keyWrapper = KeychainWrapper()
                    keyWrapper.mySetObject(self.txtNewPassword.text, forKey: kSecValueData)
                    keyWrapper.writeToKeychain()
                }
                let alert = UIAlertController(title: "XPower", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    func showAlert(_ title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
