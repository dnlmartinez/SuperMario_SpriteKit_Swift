//
//  AppDelegate.swift
//  SuperJoel
//
//  Created by daniel martinez gonzalez on 27/3/17.
//  Copyright © 2017 daniel martinez gonzalez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool{
        self.LoadDefaults()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func LoadDefaults(){
        if !UserDefaults.standard.bool(forKey: "score")
        {
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            UserDefaults.standard.set(0 , forKey: "score")
            UserDefaults.standard.set(1, forKey: "mundoSelected")
            
            UserDefaults.standard.set(false , forKey: "nivel-1-completed")
            UserDefaults.standard.set(false , forKey: "nivel-2-completed")
            UserDefaults.standard.set(false , forKey: "nivel-3-completed")
            UserDefaults.standard.set(false , forKey: "nivel-4-completed")
            UserDefaults.standard.set(false , forKey: "nivel-5-completed")
            UserDefaults.standard.set(false , forKey: "nivel-6-completed")
            UserDefaults.standard.set(false , forKey: "nivel-7-completed")
            UserDefaults.standard.set(false , forKey: "nivel-8-completed")
            UserDefaults.standard.set(false , forKey: "nivel-9-completed")
            UserDefaults.standard.set(false , forKey: "nivel-10-completed")
            UserDefaults.standard.set(false , forKey: "nivel-11-completed")
            UserDefaults.standard.set(false , forKey: "nivel-12-completed")
            UserDefaults.standard.set(false , forKey: "nivel-13-completed")
            UserDefaults.standard.set(false , forKey: "nivel-14-completed")
            UserDefaults.standard.set(false , forKey: "nivel-15-completed")
            UserDefaults.standard.set(false , forKey: "nivel-16-completed")
            UserDefaults.standard.set(false , forKey: "nivel-17-completed")
            UserDefaults.standard.set(false , forKey: "nivel-18-completed")
            UserDefaults.standard.set(false , forKey: "nivel-19-completed")
            UserDefaults.standard.set(false , forKey: "nivel-20-completed")
            UserDefaults.standard.set(false , forKey: "nivel-21-completed")
            UserDefaults.standard.set(false , forKey: "nivel-22-completed")
            UserDefaults.standard.set(false , forKey: "nivel-23-completed")
            UserDefaults.standard.set(false , forKey: "nivel-24-completed")
            UserDefaults.standard.set(0, forKey: "GoombaDied")
            UserDefaults.standard.set(0, forKey: "MisilDied")
            UserDefaults.standard.set(0, forKey: "TurtleDied")
            UserDefaults.standard.set(0, forKey: "TempGoombaDied")
            UserDefaults.standard.set(0, forKey: "TempMisilDied")
            UserDefaults.standard.set(0, forKey: "TempTurtleDied")
        }
    }

}

