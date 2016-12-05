//
//  AppDelegate.swift
//  FabuzaExampleSwift
//
//  Created by Ilya Tarasov on 23.08.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

import UIKit
import SCKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = FZTestEngine.instance().window

    let schemeName = "fabuzaExample"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FZTestEngine.instance().on()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        FZTestEngine.instance().externalUrl = url
        return true
    }
    
}
