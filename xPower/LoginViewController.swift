//
//  ViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/17/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import MBProgressHUD
import LocalAuthentication

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textUsername : UITextField!
    @IBOutlet weak var textPassword : UITextField!
    @IBOutlet weak var switchKeepLogin : UISwitch!

    var alertEmail: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imgView=UIImageView(frame: self.view.bounds)
        imgView.loadFromFile(photo:"Tree")
        self.view.addSubview(imgView)
        self.view.sendSubview(toBack: imgView)
        
        //Insert data into KeychainWrapper
        let keychain = KeychainWrapper()
        let username = keychain.myObject(forKey: kSecAttrAccount) as? String
    
        if let user=username,user.characters.count > 0{
            let isKeepLogIn = UserDefaults.standard.bool(forKey: AppDefault.KeepLogIn)
            if isKeepLogIn {
                let touch = UserDefaults.standard.bool(forKey: AppDefault.TouchID)
                if  touch {
                    self.authenticateUser()
                }
                else {
                    // Load Home view
                    CommonViewController.loadHomeView()
                }
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden=false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authenticateUser(){
        let context=LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        {
            let reason="Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                      CommonViewController.loadHomeView()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }

        }
        else{
            CommonViewController.loadHomeView()
        }
    }
    
    @IBAction func pressClearButton(_sender:Any)
    {
        self.textUsername.text=""
        self.textPassword.text=""
    }

    @IBAction func pressForgotPasswordBtn(_sender:Any)
    {
        alertEmail=UIAlertController(title: "Forgot Password", message: nil, preferredStyle: .alert)
        let actionSend=UIAlertAction(title: "send", style: .default) { (action) in
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let emailId=self.alertEmail.textFields?.first?.text
            
            WebServiceManager.forgotPassword(email: emailId!, completionHandler: {(isSuccess,message) in
            
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for:self.view,animated:true)
                    let alert=UIAlertController(title: "xPower", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert,animated: true,completion: nil)
                }
            })
        }
        let actionCancel=UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertEmail.addTextField { (textEmailAddress) in
            textEmailAddress.placeholder="Please Enter your Email Address"
            textEmailAddress.delegate=self
        }
        alertEmail.addAction(actionCancel)
        alertEmail.addAction(actionSend)
        actionSend.isEnabled=false
        self.present(alertEmail,animated: true,completion: nil)
    }
    
    @IBAction func pressLoginBtn(_sender:Any)
    {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.loginUser(username: self.textUsername.text!, password: self.textPassword.text!)
        { (isSuccess, dictData, message) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for:self.view,animated:true)
                if isSuccess{
                
                    //Store password in Keychain code left
                
                    UserDefaults.standard.set(dictData.username,forKey:AppDefault.Username)
                    UserDefaults.standard.set(dictData.password,forKey:AppDefault.SelectSchool)
                
                    //If Keep me Login Switch is On then store Switch value in UserFaults
                    if self.switchKeepLogin.isOn {
                        UserDefaults.standard.set(true, forKey: AppDefault.KeepLogIn)
                        UserDefaults.standard.synchronize()
                    }
                    //Load After Login Page
                    CommonViewController.loadHomeView()
                }
                else
                {
                    let alert:UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert,animated: true,completion: nil)
                }
            }
        }
    }
    
    @IBAction func valueChangeKeepLogin(_ sender: Any) {
    }
    
    @IBAction func tapView(_sender: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }


    //pragma Mark - TextField Delegate Method
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.characters.count)! > 10 {
            alertEmail.actions.last?.isEnabled = true
        }
        else {
            alertEmail.actions.last?.isEnabled = false
        }
        return true
    }
}


