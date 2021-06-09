//
//  AppDelegate.swift
//  BackbaseTask
//
//  Created by SAMEH on 05/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureRootViewController()
        
        return true
    }
    
    func configureRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = CitiesRouter().viewController
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        rootNavigationController.setNavigationBarHidden(false, animated: false)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
    
    
}

