//
//  AppDelegate.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 13/12/2019.
//  Copyright © 2019 Alejandro Marañés. All rights reserved.
//
import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var storyBoard :UIStoryboard?
    var navigationController : UINavigationController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //give notification permission
        
        // Override point for customization after application launch.
        return true
    }
    func startNavViewController() {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        if navigationController == nil {
            navigationController = UINavigationController()
        }
        if storyBoard == nil {
            storyBoard = UIStoryboard(name: "Main", bundle:nil)
        }
        navigationController?.setNavigationBarHidden(true, animated: true)
        let homeVC: SeleccionarAppsVC
        // storyboard with identifer
        homeVC = storyBoard?.instantiateViewController(withIdentifier: "SeleccionarAppsVC") as! SeleccionarAppsVC
        navigationController?.pushViewController(homeVC , animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
