/*
 Copyright (c) 2016 Sachin Verma
 
 SVMenuOptionManager.swift
 SVSlidingPanel
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
import UIKit

enum SVMenuOptions {
//    case Audi
//    case BMW
//    case Honda
//    case Tata
//    case Toyota
//    case Suzuki
//    case Nissan
//    case Volkswagen
//    case Volvo
//    case Jaguar
//    case Fiat
//    case Ford
    
    var menuTitle: String {
        
        return String(describing: self)
    }
    
}


class SVMenuOptionManager: NSObject {
    
    static let sharedInstance = SVMenuOptionManager()
    
    let slidingPanel: SVSlidingPanelViewController
    
    
    override init() {
        
        self.slidingPanel = SVSlidingPanelViewController()
        
        super.init()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let  lefthamburgerMenuController : LeftMenuTableViewController = storyboard.instantiateViewController(withIdentifier: "LeftMenuTableViewController") as! LeftMenuTableViewController
        
        let  detailController : HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let navigation = UINavigationController(rootViewController:detailController)
        
        self.slidingPanel.leftPanel = lefthamburgerMenuController
        self.slidingPanel.centerPanel = navigation
        
        lefthamburgerMenuController.menuSelectionClosure = {[weak self](selectedIndexPath: IndexPath, animated:Bool) in
            self?.showScreenForMenuOption(selectedIndex: selectedIndexPath, animation: animated)
        }
    }
    
    func showScreenForMenuOption(selectedIndex: IndexPath, animation animated: Bool) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = self.slidingPanel.centerPanel as! UINavigationController
        
        print("press: \(selectedIndex.row)")
        switch selectedIndex.row {
        case 0:
            // Home
            let homeVC: HomeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController.viewControllers = [homeVC]
            break
        case 1:
            // Points
            let pointsVC: PointsTabbarViewController = mainStoryboard.instantiateViewController(withIdentifier: "PointsTabbarViewController") as! PointsTabbarViewController
            navigationController.viewControllers = [pointsVC]
            break
        case 2:
            // Score
            let scoreVC: ScoreViewController = mainStoryboard.instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
            navigationController.viewControllers = [scoreVC]
            break
        case 3:
            // Friends
            let friendVC: FriendViewController = mainStoryboard.instantiateViewController(withIdentifier: "FriendViewController") as! FriendViewController
            navigationController.viewControllers = [friendVC]
            break
        case 4:
            // Settings
            let settingVC: SettingViewController = mainStoryboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
            navigationController.viewControllers = [settingVC]
            break
        case 5:
            // Logout
            let keyWrapper = KeychainWrapper()
            keyWrapper.mySetObject("", forKey: kSecValueData)
            keyWrapper.mySetObject("", forKey: kSecAttrAccount)
            keyWrapper.writeToKeychain()
            
            CommonViewController.resetFriendRequest()
            CommonViewController.loadLoginView()
            break
        default:
            break
        }
        self.slidingPanel.showCenterPanel(animated: animated)
    }
}
