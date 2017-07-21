//
//  ReportViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import MessageUI

class ReportViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var txtvReport: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let sendBtn = UIBarButtonItem (title: "Send", style: .done, target: self, action: #selector(reportViaMail))
        self.navigationItem.rightBarButtonItem = sendBtn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reportViaMail() {
        
        if MFMailComposeViewController.canSendMail(){
            let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
            let message = "\(username) has following concerns: \n\(self.txtvReport.text!)"
            
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients(["jayraj_gohil@softwaremerchant.com"]) //xpower3578@gmail.com
            mailComposerVC.setSubject("Concerns")
            mailComposerVC.setMessageBody(message, isHTML: false)
            self.present(mailComposerVC, animated: true, completion: nil)
        }
        else{
            self.showSendMailErrorAlert()
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
