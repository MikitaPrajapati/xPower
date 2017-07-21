//
//  FavoriteViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import MBProgressHUD

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,PointTableCellDelegate  {

    @IBOutlet weak var tblPoint: UITableView!
    
    var arrayFav = [TasksList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "favorites-1")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
        
        self.tblPoint.register(UINib(nibName:"PointTableViewCell", bundle: nil), forCellReuseIdentifier: "PointTableViewCell")
        self.tblPoint.estimatedRowHeight = 60
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.pointFavoriteGet(username: username, completionHandler:{ (isSuccess, responseData, message) in
            
            DispatchQueue.main.async {
                
                self.arrayFav = responseData.tasksList;
                self.tblPoint.reloadData();
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PointTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PointTableViewCell") as! PointTableViewCell
        cell.delegate = self;
        cell.tag = indexPath.row
        cell.lblTitle.text = arrayFav[indexPath.row].task
        cell.isFavorite = true
        cell.btnFavorite.setImage(UIImage(named: "favorites"), for: .normal)
        return cell
    }
    
    func pointDeedAdded(at: Int) {
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        let deedSelected = arrayFav[at].task
        let dateToday = Date()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.pointAddDeeds(username: username, deed: deedSelected!, date: dateToday, completionHandler: {(isSuccess, message) -> () in
            DispatchQueue.main.async {
                
                MBProgressHUD.hide(for: self.view, animated: true)
                let alert = UIAlertController(title: "XPower", message: message, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    // your code with delay
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        })
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
                
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 2
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
