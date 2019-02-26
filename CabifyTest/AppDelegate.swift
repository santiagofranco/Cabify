//
//  AppDelegate.swift
//  CabifyTest
//
//  Created by Santi on 25/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow()
        setupAbsNet()
        
        return true
    }
    
    
    fileprivate func setupAbsNet() {
        let config = AbsNetConfiguration(url: "https://api.myjson.com/")
        ApiService.with(configuration: config)
    }
    
    fileprivate func setupWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let nav = UINavigationController(rootViewController: ProductListModule().provide())
        self.window?.rootViewController = nav
        
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
    }
    

}

