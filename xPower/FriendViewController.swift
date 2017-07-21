//
//  FriendViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit
import MBProgressHUD

class FriendViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FriendRequestDelegate {

    @IBOutlet weak var segmentFriend: UISegmentedControl!
    @IBOutlet weak var tblFriend: UITableView!
    
    var friendListModel: FriendListModel = FriendListModel(fromDictionary: NSDictionary())
    var friendReqModel: FriendRequestListModel = FriendRequestListModel(fromDictionary: NSDictionary())
    var al_sendReq:UIAlertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "addfriend")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
        
        let barAddBtn: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
        self.navigationItem.rightBarButtonItem = barAddBtn
        
        self.segmentFriend.selectedSegmentIndex = 0;
//        loadFriendList()
//        loadFriendRequest()

//        let operationqueue = OperationQueue()
//        let op_list = BlockOperation{
//            DispatchQueue.main.async {
                self.loadFriendList()
//            }
//        }
//        let op_req = BlockOperation{
            let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                // Your code with delay
                self.loadFriendRequest()
            }
//        }
//        operationqueue.addOperations([op_list,op_req], waitUntilFinished: true)
        
        
        self.tblFriend.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func addFriend() {
        print("Add Friend")
        
        al_sendReq = UIAlertController(title: AppDefault.AppName, message: "Send request", preferredStyle: .alert)
        al_sendReq.addTextField { (txtUsername) in
            txtUsername.placeholder = "Enter username"
        }
        al_sendReq.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        al_sendReq.addAction(UIAlertAction(title: "Send", style: .destructive, handler: { alertSend in
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            let senderUsername = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
            let receiverUserName = self.al_sendReq.textFields?.first?.text
            
            WebServiceManager.friendAdd(sender: senderUsername, receiver: receiverUserName!, completionHandler: { (isSuccess, message) in
                
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let alert = UIAlertController(title: "xPower", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }))
        self.present(al_sendReq, animated: true, completion: nil)
    }
    
    func loadFriendList() {
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.friendList(username: username, completionHandler: { (isSuccess, responseData, message) in
            
            DispatchQueue.main.async {
                if isSuccess {
                    self.friendListModel = responseData;
                    self.tblFriend.reloadData();
                }
                
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
    }
    
    func loadFriendRequest() {
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
       
        let friendHud = MBProgressHUD(for: self.view)
        friendHud?.show(animated: true)
        WebServiceManager.friendRequestList(username: username, completionHandler: { (isSuccess, responseData, message) in
            
            DispatchQueue.main.async {
                if isSuccess {
                    self.friendReqModel = responseData;
                    self.segmentFriend.setTitle("Request (\(self.friendReqModel.count!))", forSegmentAt: 1)
                    
                    if self.segmentFriend.selectedSegmentIndex == 1{
                        self.tblFriend.reloadData();
                    }
                    
                    let vc:LeftMenuTableViewController = SVMenuOptionManager.sharedInstance.slidingPanel.leftPanel as! LeftMenuTableViewController
                    
                    if self.friendReqModel.requests.count > 0{
                        
                        let application = UIApplication.shared
                        application.applicationIconBadgeNumber = responseData.requests.count
                        
                        let strFrnd =  "\(Menu.Friends) (\(self.friendReqModel.requests.count) new)"
                        vc.arrayMenu[3] = strFrnd
                        vc.tableView.reloadData()
                    }
                    else{
                        UIApplication.shared.applicationIconBadgeNumber = 0
                        vc.arrayMenu[3] = Menu.Friends
                        vc.tableView.reloadData()
                    }
                    
                }
                friendHud?.hide(animated: true)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentFriend.selectedSegmentIndex == 0 {
            return self.friendListModel.friends.count
        }
        else {
            return self.friendReqModel.requests.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segmentFriend.selectedSegmentIndex == 0 {
            // List
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendList", for: indexPath)
            cell.textLabel?.text = self.friendListModel.friends[indexPath.row].username
            return cell

        }
        else {
            
            let cell : FriendRequestTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FriendRequestTableViewCell") as! FriendRequestTableViewCell
            cell.delegate = self;
            cell.tag = indexPath.row
            cell.lblName.text = self.friendReqModel.requests[indexPath.row].username
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if segmentFriend.selectedSegmentIndex == 0 {
            let chatVC: ChatViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            chatVC.receiver = self.friendListModel.friends[indexPath.row].username
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
    }
    
    func requestAccept(at: Int) {
        print("Accept at \(at)")
        friend(status: true, name: self.friendReqModel.requests[at].username)
    }
    
    func requestReject(at: Int) {
        print("Reject at \(at)")
        friend(status: false, name: self.friendReqModel.requests[at].username)
    }
    
    func friend(status:Bool, name: String) {
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as! String
        let statusResponse = status ? 2 : 0
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebServiceManager.friendStatusResponse(sender: username, receiver: name, status: statusResponse, completionHandler: { (isSuccess, message) in
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                let alert = UIAlertController(title: "xPower", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { actionOK in
                    self.loadFriendRequest()
                }))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func valueChangeFriend(_ sender: Any) {
        if segmentFriend.selectedSegmentIndex == 0 {
            loadFriendList()
        }
        else{
            loadFriendRequest()
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
