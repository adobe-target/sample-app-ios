//
//  AppDelegate.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  private var indicator = MaterialActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 45, height: 45))

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.profileSettingToast()
        }
        return true
    }
    func profileSettingToast()  {
        var strDetail = ""
        if let name = UserDefaults.getProfileDetails().0 { strDetail += "Name - \(name) "}
        if let launchId = UserDefaults.getSettingsDetails().0 { strDetail += "\nLaunch ID - \(launchId)"}
        if strDetail.count > 0 {
            let alert = UIAlertController(title: nil, message: strDetail, preferredStyle: UIAlertController.Style.alert)        // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))        // show the alert
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
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
    func startIndicator() {
        indicator = MaterialActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 45, height: 45))
        indicator.color = UIColor.init(red: 53.0/255.0, green: 114.0/255.0, blue: 222.0/255.0, alpha: 1)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.center = window?.center ?? CGPoint.init()
        indicator.startAnimating()
        window?.addSubview(indicator)
    }
    func stopIndicator() {
        indicator.removeFromSuperview()
        indicator.vi.removeFromSuperview()
    }
}


