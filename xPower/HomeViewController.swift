//
//  HomeViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import MBProgressHUD

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
//progresscell
    @IBOutlet weak var lblTotalSchoolPoint: UILabel!
    @IBOutlet weak var lblDailyPoints: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var progModel:ProgressModel?
    
    let reuseIdentifier = "progresscell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "homescreenbackground")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        progModel = ProgressModel(fromDictionary: NSDictionary())
        self.collectionView.reloadData()

        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        self.lblDailyPoints.text = "0"
        self.lblTotalSchoolPoint.text = "0"
        
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String

        let queue = OperationQueue()
        
        let op_dailyPoint = BlockOperation {
            WebServiceManager.dailyPoints(username: username, completionHandler: { (isSuccess, message) in
                
                DispatchQueue.main.async {
                    print("daily point")
                    if isSuccess{
                        self.lblDailyPoints.text = message;
                    }
                }
                
            })
        }
        
        let op_totalPoint = BlockOperation{
            WebServiceManager.totalUserPoints(username: username, completionHandler: { (isSuccess, message) in
                
                DispatchQueue.main.async {
                    print("total point")
                    if isSuccess{
                        self.lblTotalSchoolPoint.text = message
                    }
                }
                
            })
        }
        
        let op_ProgressPoint = BlockOperation{
            WebServiceManager.progressPoint(username: username, year: "2017", completionHandler: { (isSuccess, responseData, message) in
                
                DispatchQueue.main.async {
                    print("total point")
                    if isSuccess{
                        self.progModel = responseData
                        if self.progModel?.error == 1 {
                            self.showAlert("XPower", message: "Invalid Username")
                        }
                        else if self.progModel?.error == 2 {
                            self.showAlert("XPower", message: "Invalid Year")
                        }
                        else{
                            self.loadProgress()
                        }
                    }
                }
                
            })
        }
        
        let op_FriendReq = BlockOperation{
            let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
            WebServiceManager.friendRequestList(username: username, completionHandler: { (isSuccess, responseData, message) in
                
                DispatchQueue.main.async {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let delegate = AppDelegate.getDelegate()
                    let isAppeared = delegate.isRequestAppear
                    
                    if (isSuccess && !isAppeared) {
                        
                        let vc:LeftMenuTableViewController = SVMenuOptionManager.sharedInstance.slidingPanel.leftPanel as! LeftMenuTableViewController
                        
                        if responseData.requests.count > 0{
                            
                            let application = UIApplication.shared
                            application.applicationIconBadgeNumber = responseData.requests.count
                            
                            let strFrnd =  "\(Menu.Friends) (\(responseData.requests.count) new)"
                            vc.arrayMenu[3] = strFrnd
                            vc.tableView.reloadData()
                            
                            delegate.isRequestAppear = true
                            
                            self.showAlert(AppDefault.AppName, message: "You have \(responseData.requests.count) pending friend request.")
                        }
                        else{
                            UIApplication.shared.applicationIconBadgeNumber = 0
                            vc.arrayMenu[3] = Menu.Friends
                            vc.tableView.reloadData()
                        }
                    }
                }
            })
        }
        
        op_totalPoint.addDependency(op_dailyPoint)
        op_ProgressPoint.addDependency(op_totalPoint)
        op_FriendReq.addDependency(op_ProgressPoint)
        queue.addOperations([op_dailyPoint, op_totalPoint, op_ProgressPoint, op_FriendReq], waitUntilFinished: false)
        
    }
    
    func loadProgress() {
        
        self.collectionView.reloadData()
    }
    
    func showAlert(_ title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if progModel != nil && progModel?.error == 0 {
            return 12
        }
        else{
            return 0
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ProgressCollectionViewCell
        
        var per = 0
        var month = ""
        var point = 0
                
        switch indexPath.row {
        case 0:
            point = (progModel?.jan)!
            per = ((progModel?.jan)! * 100 / (progModel?.maxPoint)!)
            month = "Jan"
        case 1:
            point = (progModel?.feb)!
            per = ((progModel?.feb)! * 100 / (progModel?.maxPoint)!)
            month = "Feb"
        case 2:
            point = (progModel?.mar)!
            per = ((progModel?.mar)! * 100 / (progModel?.maxPoint)!)
            month = "Mar"
        case 3:
            point = (progModel?.apr)!
            per = ((progModel?.apr)! * 100 / (progModel?.maxPoint)!)
            month = "Apr"
        case 4:
            point = (progModel?.may)!
            per = ((progModel?.may)! * 100 / (progModel?.maxPoint)!)
            month = "May"
        case 5:
            point = (progModel?.jun)!
            per = ((progModel?.jun)! * 100 / (progModel?.maxPoint)!)
            month = "Jun"
        case 6:
            point = (progModel?.jul)!
            per = ((progModel?.jul)! * 100 / (progModel?.maxPoint)!)
            month = "Jul"
        case 7:
            point = (progModel?.aug)!
            per = ((progModel?.aug)! * 100 / (progModel?.maxPoint)!)
            month = "Aug"
        case 8:
            point = (progModel?.sep)!
            per = ((progModel?.sep)! * 100 / (progModel?.maxPoint)!)
            month = "Sep"
        case 9:
            point = (progModel?.oct)!
            per = ((progModel?.oct)! * 100 / (progModel?.maxPoint)!)
            month = "Oct"
        case 10:
            point = (progModel?.nov)!
            per = ((progModel?.nov)! * 100 / (progModel?.maxPoint)!)
            month = "Nov"
        case 11:
            point = (progModel?.dec)!
            per = ((progModel?.dec)! * 100 / (progModel?.maxPoint)!)
            month = "Dec"
        default: break
        }
        
        let intervalPoint = (progModel?.maxPoint)! / 5
        
        
        if point < (intervalPoint * 1) {
            cell.imgvProgress.image = UIImage(named: "Tree1")
        }
        else if point < (intervalPoint * 2) {
            cell.imgvProgress.image = UIImage(named: "Tree3")
        }
        else if  point < (intervalPoint * 3) {
            cell.imgvProgress.image = UIImage(named: "Tree4")
        }
        else if  point < (intervalPoint * 4) {
            cell.imgvProgress.image = UIImage(named: "Tree5")
        }
        else {
            cell.imgvProgress.image = UIImage(named: "Tree6")
        }
        
        if per >= 100
        {
            per = 100
        }
        
        cell.lblProgress.text = "\(month) - \(per)%"
        
        /*
        let v = ProgressView(frame: cell.contentView.bounds)
        
        switch indexPath.row {
        case 0:
            let per = ((progModel?.jan)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Jan")
        case 1:
            let per = ((progModel?.feb)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Feb")
        case 2:
            let per = ((progModel?.mar)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Mar")
        case 3:
            let per = ((progModel?.apr)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Apr")
        case 4:
            let per = ((progModel?.may)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "May")
        case 5:
            let per = ((progModel?.jun)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Jun")
        case 6:
            let per = ((progModel?.jul)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Jul")
        case 7:
            let per = ((progModel?.aug)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Aug")
        case 8:
            let per = ((progModel?.sep)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Sep")
        case 9:
            let per = ((progModel?.oct)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Oct")
        case 10:
            let per = ((progModel?.nov)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Nov")
        case 11:
            let per = ((progModel?.dec)! * 100 / (progModel?.maxPoint)!)
            v.animateProgressView(percentage: per, month: "Dec")
        default:
            v.animateProgressView(percentage: 0, month: "")
        }
        for subv in cell.contentView.subviews {
            if subv is ProgressView {
                subv.removeFromSuperview()
            }
        }
        cell.contentView.addSubview(v)
 
 */
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
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
