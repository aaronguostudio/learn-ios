//
//  AppDelegate.swift
//  tobedone
//
//  Created by ArronStudio on 2019-07-09.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        FirebaseApp.configure()
        
        return true
    }

}

