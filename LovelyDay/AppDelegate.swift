//
//  AppDelegate.swift
//  LovelyDay
//
//  Created by Tielman Janse van Vuuren on 2020/12/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds);
        }
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
        return true
    }
}

