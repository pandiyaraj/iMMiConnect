//
//  AppDelegate.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 09/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootController: UIViewController?
    var storyboard: UIStoryboard!
    static let shared = UIApplication.shared.delegate as! AppDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Load Initial Setup
    
    // MARK: - login -
    func CheckForLogin() {
        
        
        // Not authenticated -- signed in.
        if UserDefaults.standard.bool(forKey: Constants.defaults.isLoggedIn)   {
            loadUserLoggedInUI()
        }else {
            loadUserLoggedOutUI()
        }
    }
    
    func loadUserLoggedInUI() {
        setUpInitialController(identifier: Constants.ViewControllerNames.DashboardVc)
        
    }
    
    func loadUserLoggedOutUI() {
        
        UserDefaults.standard.set(false, forKey: Constants.defaults.isLoggedIn)
        //        if #available(iOS 10.0, *){
        //            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        //        }else{
        //            UIApplication.shared.cancelAllLocalNotifications()
        //        }
        
        self.setUpInitialController(identifier: Constants.ViewControllerNames.LoginNavVC)
    }
    
    func setUpInitialController(identifier : String){
        self.rootController?.removeFromParentViewController()
        self.rootController = nil
        let navVC = self.storyboard.instantiateViewController(withIdentifier: identifier) as! UINavigationController
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
    }
}

