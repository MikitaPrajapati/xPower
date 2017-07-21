//
//  PointViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import MBProgressHUD

class PointViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,PointTableCellDelegate, UISearchBarDelegate {

    @IBOutlet weak var segmentPoints: UISegmentedControl!
    @IBOutlet weak var tblPoint: UITableView!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var constraint_btnHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var arrayPoint = [PointTable]()
    var arrayRecent = [RecentDeedModel]()
    var arrayFav = [TasksList]()
    var arraySearchPoint = [PointTable]()
    var arraySearchRecent = [RecentDeedModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "addpointsbackground")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
        
        self.tblPoint.register(UINib(nibName:"PointTableViewCell", bundle: nil), forCellReuseIdentifier: "PointTableViewCell")
        self.tblPoint.estimatedRowHeight = 60
        
        self.segmentPoints.selectedSegmentIndex = 0;
        self.constraint_btnHeight.constant = 0;
        self.btnDate.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPoints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentValueChange(_ sender: Any) {
        
        self.view.endEditing(true)
        self.searchBar.text = ""
        
        if self.segmentPoints.selectedSegmentIndex == 0 {
            self.constraint_btnHeight.constant = 0;
            self.btnDate.isHidden = true
            loadPoints()
        }
        else {
            self.btnDate.isHidden = false
            self.constraint_btnHeight.constant = 0;
            loadDailyDeeds()
        }
    }

    @IBAction func pressDateBtn(_ sender: Any) {
    }
    
    func loadPoints() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.pointListTable { (isSuccess, responseData, message) in
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.arrayPoint = responseData;
                self.arraySearchPoint = responseData
                self.favoriteGet()
            }
        }
    }
    
    func loadDailyDeeds() {
        
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.pointRecentDeeds(username: username, completionHandler:{ (isSuccess, responseData, message) in
            
            DispatchQueue.main.async {
                
                self.arrayRecent = responseData;
                self.arraySearchRecent = responseData
                self.tblPoint.reloadData();
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentPoints.selectedSegmentIndex == 0 {
            return self.arraySearchPoint.count
        }
        else {
            return self.arraySearchRecent.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PointTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PointTableViewCell") as! PointTableViewCell
        
        if segmentPoints.selectedSegmentIndex == 0 {
            cell.delegate = self;
            cell.tag = indexPath.row
            cell.constraint_BtnWidth.constant = 30
            cell.lblTitle.text = arraySearchPoint[indexPath.row].descriptionField
        }
        else {
            cell.delegate = nil
            cell.constraint_BtnWidth.constant = 0;
            cell.lblTitle.text = arraySearchRecent[indexPath.row].deed
        }
        
        let ff = NSPredicate(format: "%K = %@", "task", cell.lblTitle.text!)
        let abc = (self.arrayFav as NSArray).filtered(using: ff)
        if abc.count > 0 {
            cell.btnFavorite.setImage(UIImage(named: "favorites"), for: .normal)
            cell.isFavorite = true
        }
        else {
            cell.btnFavorite.setImage(UIImage(named: "NoFavorite"), for: .normal)
            cell.isFavorite = false
        }
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText)")
        
        if searchText == ""{
            if  segmentPoints.selectedSegmentIndex == 0 {
                self.arraySearchPoint = self.arrayPoint
            }
            else {
                self.arraySearchRecent = self.arrayRecent
            }
            self.tblPoint.reloadData()
        }
        else {
            self.filterArrayWithSearch(searchText: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func filterArrayWithSearch(searchText: String) {
        
        if segmentPoints.selectedSegmentIndex == 0 {
            let resultPredicate = NSPredicate(format: "descriptionField contains[c] %@", searchText)
            self.arraySearchPoint = (self.arrayPoint as NSArray).filtered(using: resultPredicate) as! [PointTable]
            print(self.arraySearchPoint.count)
        }
        else {
            let resultPredicate = NSPredicate(format: "deed contains[c] %@", searchText)
            self.arraySearchRecent = (self.arrayRecent as NSArray).filtered(using: resultPredicate) as! [RecentDeedModel]
            print(self.arraySearchRecent.count)
        }
        
        self.tblPoint.reloadData()
    }
    
    func pointDeedAdded(at: Int) {
        
        if segmentPoints.selectedSegmentIndex == 0 {
            let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
            let deedSelected = arraySearchPoint[at].descriptionField
            let dateToday = Date()
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            WebServiceManager.pointAddDeeds(username: username, deed: deedSelected!, date: dateToday, completionHandler: {(isSuccess, message) -> () in
                DispatchQueue.main.async {
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let alert = UIAlertController(title: "XPower", message: message, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    
                    // change to desired number of seconds (in this case 5 seconds)
                    let when = DispatchTime.now()
                    DispatchQueue.main.asyncAfter(deadline: when){
                        // your code with delay
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    func favoriteAdded(at: Int, isFav: Bool) {
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        let cell: PointTableViewCell = self.tblPoint.cellForRow(at: IndexPath(row: at, section: 0)) as! PointTableViewCell
        let task = cell.lblTitle.text
        
        var isFavorite = isFav
        if isFavorite  {
            isFavorite = false
        }else{
            isFavorite = true
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.pointFavoriteSet(username: username, isFavorite: isFavorite, task: task!, completionHandler: {(isSuccess, message) -> () in
            DispatchQueue.main.async {
                
                MBProgressHUD.hide(for: self.view, animated: true)
                let alert = UIAlertController(title: "XPower", message: message, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                
                // change to desired number of seconds (in this case 1 seconds)
                let when = DispatchTime.now()
                DispatchQueue.main.asyncAfter(deadline: when){
                    // your code with delay
                    alert.dismiss(animated: true, completion: nil)
                    self.favoriteGet()
                }
            }
        })
    }
    
    func favoriteGet() {
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.pointFavoriteGet(username: username, completionHandler:{ (isSuccess, responseData, message) in
            
            DispatchQueue.main.async {
                self.arrayFav = responseData.tasksList;
                self.tblPoint.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
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
