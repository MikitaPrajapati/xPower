//
//  SignUpViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import MBProgressHUD

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgvBackground: UIImageView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var btnSchool: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtEmailHost: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.btnSchool.titleLabel?.textAlignment = NSTextAlignment.center
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "signup")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.navigationController?.isNavigationBarHidden  = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        self.navigationController?.isNavigationBarHidden  = true
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tapAvatar(_ sender: UITapGestureRecognizer) {
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        var selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        selectedImage = CommonViewController.resizeImage(image: selectedImage, newWidth: CGFloat(ProgilePic.width))
        // Set photoImageView to display the selected image.
        self.imgAvatar.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressSelectSchoolBtn(_ sender: Any) {
        let alertEmailHost = UIAlertController(title: AppDefault.AppName, message: AppDefault.SelectSchool, preferredStyle: .actionSheet)
        let actionHavord = UIAlertAction(title: School.HaverfordName, style: .default, handler: {(action) -> Void in
            self.btnSchool.setTitle(School.HaverfordName, for: .normal)
            self.txtEmailHost.text = School.HaverfordEmail
            
        })
        let actionAgnes = UIAlertAction(title: School.AgnesIrwinName, style: .default, handler: {action in
            self.btnSchool.setTitle(School.AgnesIrwinName, for: .normal)
            self.txtEmailHost.text = School.AgnesIrwinEmail
        })
        alertEmailHost.addAction(actionHavord)
        alertEmailHost.addAction(actionAgnes)
        self.present(alertEmailHost, animated: true, completion: nil)
    }
    
    @IBAction func pressSignupBtn(_ sender: Any) {
        
        if (self.txtUsername.text?.isEmpty)! || (self.txtPassword.text?.isEmpty)! || (self.txtConfirmPassword.text?.isEmpty)! || (self.txtEmail.text?.isEmpty)! {
            self.showAlert("Error", message: "Plase fill all the informaiton")
            return
        }
        else if self.txtPassword.text != self.txtConfirmPassword.text {
            self.showAlert("XPower", message: "Confirm password does not match with password")
            return
        }
        else if self.btnSchool.titleLabel?.text == "Select School"{
            self.showAlert("XPower", message: "Please select school")
            return
        }
        
        let strEmail = "\(txtEmail.text! + (txtEmailHost.text)!)"
        let strSchoolName = (btnSchool.titleLabel?.text == School.HaverfordName) ? School.HaverfordName : School.Param_AgnesIrwinSchool.lowercased()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.signup(username: self.txtUsername.text!, password: self.txtPassword.text!, email: strEmail, schoolname: strSchoolName, avatar: false, avatarURl: "", completionHandler: {(isSuccess, message) -> () in
            
            DispatchQueue.main.async {
                
                MBProgressHUD.hide(for: self.view, animated: true)
                
                if isSuccess {
                    
                    // reset friend reqeust
                    CommonViewController.resetFriendRequest()
                    
                    // Store password in Keychain
//                    let keyWrapper = KeychainWrapper()
//                    keyWrapper.mySetObject(self.txtPassword.text, forKey: kSecValueData)
//                    keyWrapper.mySetObject(self.txtUsername.text, forKey: kSecAttrAccount)
//                    keyWrapper.writeToKeychain()
                    
                    UserDefaults.standard.set(self.txtUsername.text, forKey: AppDefault.Username)
                    UserDefaults.standard.set(strSchoolName, forKey: AppDefault.SchoolName)
                    
                    // check if keep me login on then store in userdefaults
                    UserDefaults.standard.set(false, forKey: AppDefault.KeepLogIn)
                    UserDefaults.standard.synchronize()
                    
                    // store avatar
                    if let data = UIImagePNGRepresentation(self.imgAvatar.image!) {
                        let filename = CommonViewController.getDocumentsDirectory().appendingPathComponent("\(self.txtUsername.text!).png")
                        try? data.write(to: filename)
                    }
                    // Load Home view
                    CommonViewController.loadHomeView()
                }
                else {
                    self.showAlert("XPower", message: message)
                }
            }
        })
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
