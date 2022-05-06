//
//  AppDelegate.swift
//  Usercentrics
//
//  Created by Ramon Vasconcelos on 5.5.2022.
//

import UIKit
import Usercentrics

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // SDK Initialization
        let options = UsercentricsOptions(settingsId: Constants.settingsID)
        UsercentricsCore.configure(options: options)
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let consentChoiceViewController = ConsentChoiceViewController()
        
        window?.rootViewController = consentChoiceViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}
