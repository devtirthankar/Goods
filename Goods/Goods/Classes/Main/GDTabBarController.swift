//
//  GDTabBarController.swift
//  Goods
//
//  Created by Tirthankar on 08/12/17.
//  Copyright © 2017 company. All rights reserved.
//

import UIKit

enum DestinationViewType {
    case dashboard
    case mycart
    case myaccount
}

class GDTabBarController: UITabBarController, GDNavDrawerDelegate {
    var _fadedBackgroundView: UIView!
    var _navDrawerVC: GDNavDrawerVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _navDrawerVC = self.storyboard?.instantiateViewController(withIdentifier: "GDNavDrawerVC") as! GDNavDrawerVC
        _navDrawerVC.delegate = self
        
        _fadedBackgroundView = UIView()
        _fadedBackgroundView.frame = self.view.bounds;
        _fadedBackgroundView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
    }
    
    func openDrawer() {
        self.addChildViewController(_navDrawerVC)
        _navDrawerVC.beginAppearanceTransition(true, animated: true)
        
        let navDrawerWidth = self.view.frame.width * 0.75
        var yaxis: CGFloat
        
        _navDrawerVC.view.frame = CGRect(x: -navDrawerWidth, y: 0, width: -navDrawerWidth, height: self.view.frame.height)
        yaxis = 0;
        
        _fadedBackgroundView.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.addSubview(self._fadedBackgroundView)
            self.view.addSubview(self._navDrawerVC.view)
            self._navDrawerVC.view.frame = CGRect(x: yaxis, y: 0, width: navDrawerWidth, height: self.view.frame.height)
            self._fadedBackgroundView.alpha = 1.0
        }, completion: {(finished) in
            self._navDrawerVC.endAppearanceTransition()
            self._navDrawerVC.didMove(toParentViewController: self)
        })
    }
    
    func closeDrawer(){
        _navDrawerVC.willMove(toParentViewController: nil)
        _navDrawerVC.beginAppearanceTransition(false, animated: true)
        
        let navDrawerWidth = self.view.frame.width * 0.75
        let navDrawerFrame  = CGRect(x: -navDrawerWidth, y: 0, width: -navDrawerWidth, height: self.view.frame.height)
        
        UIView.animate(withDuration: 0.5, animations: {
            self._fadedBackgroundView.alpha = 0.0
            self._navDrawerVC.view.frame = navDrawerFrame;
        }, completion: {(finished) in
            self._navDrawerVC.endAppearanceTransition()
            self._navDrawerVC.view .removeFromSuperview()
            self._fadedBackgroundView.removeFromSuperview()
            self._navDrawerVC.removeFromParentViewController()
        })
        
    }
    
    //MARK: GDNavDrawerDelegate
    func didSelectCloseDrawer(){
        self.closeDrawer()
    }
    
    func didSelectItemType (_ type: NavDrawerItemType) {
        self.closeDrawer()
        switch (type){
            //case .home:
        //break
        case .search:
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "GDSearchVC")
            controller.hidesBottomBarWhenPushed = true
            let navcon = self.selectedViewController as! UINavigationController;
            navcon.pushViewController(controller, animated: true);
            
        case .myCart:
            if let _ = GDLogin.loggedInUser()?.token {
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "GDMyCartVC")
                controller.hidesBottomBarWhenPushed = true
                let navcon = self.selectedViewController as! UINavigationController;
                navcon.pushViewController(controller, animated: true);
            }else {
                global.destinationViewType = DestinationViewType.mycart
                bringUpLoginView()
            }
            
        case .myAccount:
            if let _ = GDLogin.loggedInUser()?.token {
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "GDMyAccountVC")
                controller.hidesBottomBarWhenPushed = true
                let navcon = self.selectedViewController as! UINavigationController;
                navcon.pushViewController(controller, animated: true);
            }else {
                global.destinationViewType = DestinationViewType.myaccount
                bringUpLoginView()
            }
            
        case .settings:
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "GDSettingsVC")
            controller.hidesBottomBarWhenPushed = true
            let navcon = self.selectedViewController as! UINavigationController;
            navcon.pushViewController(controller, animated: true);
            
        case .logout:
            logoutuser()
        }
        //        global.destinationViewType = DestinationViewType.dashboard
        //        print("-------- Default view set to DASHBOARD --------")
    }
    
    func logoutuser() {
        if let _ = GDLogin.loggedInUser()?.token {
            GDStorage.sharedStorage.deleteEntityFromDBEntityName("GDLogin")
            GDStorage.sharedStorage.deleteEntityFromDBEntityName("GDUserProfile")
            backToDashboard()
        }
        else {
            global.destinationViewType = DestinationViewType.dashboard
            bringUpLoginView()
        }
    }
    
    func bringUpLoginView() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GDSignInVC")
        controller.hidesBottomBarWhenPushed = true
        let navcon = self.selectedViewController as! UINavigationController;
        navcon.pushViewController(controller, animated: true);
    }
    
    func backToDashboard() {
        GDAlertAndLoader.showAlertMessage(NSLocalizedString(GDMessage.logoutSuccess, comment: ""))
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if(aViewController is GDNearYouVC || aViewController is GDSearchVC || aViewController is GDMapViewVC){
                global.destinationViewType = DestinationViewType.dashboard
                self.navigationController!.popToViewController(aViewController, animated: true)
                return
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for var touch in touches {
            if (touch.view?.isEqual(_fadedBackgroundView))!{
                closeDrawer()
            }
        }
    }
}
