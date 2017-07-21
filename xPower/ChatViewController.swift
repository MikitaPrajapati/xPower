//
//  ChatViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import MBProgressHUD

extension NSDate {
    
    // or an extension function to format your date
    func formattedWith(format:String)-> String {
        let formatter = DateFormatter()
        //formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)  // you can set GMT time
        formatter.timeZone = NSTimeZone.local        // or as local time
        formatter.dateFormat = format
        return formatter.string(from: self as Date)
    }
    
}

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {

    @IBOutlet weak var tblChat: UITableView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var txtvMessage: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var constraint_view_bottom: NSLayoutConstraint!
    
    var chatMessageModel:ChatGetMessageModel = ChatGetMessageModel(fromDictionary: NSDictionary())
    var username:String? = nil
    
    var receiver:String? = nil
    var timer:Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "addfriend")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.btnSend.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        username = UserDefaults.standard.object(forKey: AppDefault.Username) as? String
        MBProgressHUD.showAdded(to: self.view, animated: true)

        self.loadMessages()
        
        
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 1.1,
                                         repeats: true) {
                                            timer in
                                            //Put the code that be called by the timer here.
                                            self.loadMessages()
            }
        } else {
            // Fallback on earlier versions
            
            timer = Timer(timeInterval: 3, target: self, selector: #selector(loadMessages), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        timer.invalidate()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.constraint_view_bottom.constant = keyboardSize.size.height
            })
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.constraint_view_bottom.constant = 0
            })
        }
    }

    @IBAction func tapTableView(_ sender: Any) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.endEditing(true)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressSendBtn(_ sender: Any) {
        
        self.view.endEditing(true)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let strdate = NSDate().formattedWith(format: "yyyy/MM/dd hh:mm:ss a")
        WebServiceManager.chatSend(sender: username!, reciever: receiver!, message: self.txtvMessage.text,  date:strdate, completionHandler:{ (isSuccess, message) in

            DispatchQueue.main.async {
                if isSuccess {
                    self.txtvMessage.text = ""
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.loadMessages()
                }
                else{
                    
                    let alert:UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: { })
                }
            }
        })
    }
    
    func loadMessages() {
        
        WebServiceManager.chatGet(sender: self.username!, reciever: self.receiver!, date:"1970/01/01 00:00:00", completionHandler:{ (isSuccess, responseData, message) in
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                if isSuccess {
                    self.chatMessageModel = responseData;
                    self.tblChat.reloadData();
                    if self.chatMessageModel.messages.count > 0 {
                        self.tblChat.scrollToRow(at: IndexPath(row: self.chatMessageModel.messages.count-1, section: 0), at: .bottom, animated: true)
                    }
                }
                else{
                    let alert:UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: { })
                }
            }
        })
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatMessageModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        
        let msg = self.chatMessageModel.messages[indexPath.row]
        cell.lblMessage.text = msg.message
        if username == msg.sender {
            cell.lblMessage.textAlignment = NSTextAlignment.right
            cell.constraint_lblTitle_Leading.constant = 80;
        }
        else{
            
            cell.lblMessage.textAlignment = NSTextAlignment.left
            cell.constraint_lblTitle_Trailing.constant = 80;
        }
        return cell
    }
    
    // MARK: - TextView Delegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView.text.characters.count == 0 && (text == " " || text == "\n"){
            self.btnSend.isEnabled = false
            return false
        }
        else if (textView.text.characters.count == 1 && text == ""){
            self.btnSend.isEnabled = false
            return true
        }
        else{
            self.btnSend.isEnabled = true
            return true
        }
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
