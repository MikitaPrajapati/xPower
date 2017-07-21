//
//  ScoreViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import MBProgressHUD

class ScoreViewController: UIViewController {

    @IBOutlet weak var lblHaverdfordPoint: UILabel!
    @IBOutlet weak var lblAISpoints: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "scoreboard-1")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let queue = OperationQueue()
        let op_HSpoints = BlockOperation {
            WebServiceManager.totalSchoolPoints(schoolName: School.HaverfordName, completionHandler: { (isSuccess, message) in
                DispatchQueue.main.async {
                    if isSuccess {
                        self.lblHaverdfordPoint.text = message;
                    }
                }
            })
        }
        let op_AISpoints = BlockOperation {
            WebServiceManager.totalSchoolPoints(schoolName: School.Param_AgnesIrwinSchool, completionHandler: { (isSuccess, message) in
                DispatchQueue.main.async {
                    if isSuccess {
                        self.lblAISpoints.text = message;
                    }
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            })
        }
        op_AISpoints.addDependency(op_HSpoints)
        queue.addOperations([op_HSpoints, op_AISpoints], waitUntilFinished: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
