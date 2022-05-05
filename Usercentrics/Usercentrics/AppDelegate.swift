//
//  AppDelegate.swift
//  Usercentrics
//
//  Created by Ramon Vasconcelos on 5.5.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let consentChoiceViewController = ConsentChoiceViewController()
        
        self.window?.rootViewController = consentChoiceViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}
