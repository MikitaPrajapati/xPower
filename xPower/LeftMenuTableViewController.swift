//
//  LeftMenuTableViewController.swift
//  xPower
//
//  Created by Mikita Gandhi on 7/20/17.
//  Copyright © 2017 Software Merchant. All rights reserved.
//

import UIKit

class LeftMenuTableViewController: UITableViewController, leftMenuHeaderDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var menuSelectionClosure: ((IndexPath, Bool)-> Void)!
    var arrayMenu = [Menu.Home, Menu.Points, Menu.Score, Menu.Friends, Menu.Settings, Menu.Logout]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let imagv = UIImageView(frame: self.view.bounds)
        imagv.loadFromFile(photo: "sidebar")
        self.view.addSubview(imagv)
        self.view.sendSubview(toBack: imagv)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: LeftMenuHeaderView = tableView.dequeueReusableCell(withIdentifier: "LeftMenuHeaderView") as! LeftMenuHeaderView
        headerView.delegate = self
        let username = UserDefaults.standard.object(forKey: AppDefault.Username) as? String
        headerView.lblUsername.text = username
        
        let docPath = CommonViewController.getDocumentsDirectory().appendingPathComponent("\(username!).png")
        let image = UIImage(contentsOfFile: docPath.path);
        headerView.imgvAvatar.image = image
        
        return headerView
        /*
        static NSString *headerIdentifier = @"HeaderIdentifier";
        UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
        [headerView.textLabel setFont:kFontHelveticaNeue];
        headerView.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"SectionHeaderText", @""),self.sbAcronym.text];
        
        return headerView;
         */
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LeftMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuTableViewCell", for: indexPath) as! LeftMenuTableViewCell

        // Configure the cell...

        cell.lblTitle.text = arrayMenu[indexPath.row]
        
        if indexPath.row == 3 {
            let myString = NSMutableAttributedString(string: arrayMenu[indexPath.row])
            let array = arrayMenu[indexPath.row].components(separatedBy: " ")
            if array.count > 1 {
                var strReq: String = "\(array[1]) \(array[2])"
                myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red , range: NSMakeRange(Menu.Friends.characters.count+2, strReq.characters.count-2))
                myString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: cell.lblTitle.font.pointSize), range: NSMakeRange(Menu.Friends.characters.count+2, strReq.characters.count-2))
                
                // set attributed text on a UILabel
                cell.lblTitle.attributedText = myString
            }
            
        }
            
        return cell
    }

 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.menuSelectionClosure(indexPath, true)
    }

    func changeAvatar() {
        
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
        // store avatar
        if let data = UIImagePNGRepresentation(selectedImage) {
            let username = UserDefaults.standard.object(forKey: AppDefault.Username) as? String
            let filename = CommonViewController.getDocumentsDirectory().appendingPathComponent("\(username!).png")
            try? data.write(to: filename)
        }
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
        self.tableView.reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
