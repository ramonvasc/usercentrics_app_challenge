//
//  UsercentricsManager.swift
//  Usercentrics_Challenge
//
//  Created by Ramon Vasconcelos on 5.5.2022.
//

import Foundation
import Usercentrics

class UsercentricsManager {
    
    static let shared = UsercentricsManager()
    
    var isReady = false
    var shouldCollectConsent = false
    var cmpData: UsercentricsCMPData?
        
    init() {
        updateUsercentricsDataIfNeeded()
    }
    
    /// Fetch data from `UsercentricsCore` to define `isReady`, `shouldCollectConsent`
    /// state and `cmpData` for custom UI.
    func updateUsercentricsDataIfNeeded() {
        UsercentricsCore.isReady { [weak self] status in
            self?.isReady = true
            self?.shouldCollectConsent = status.shouldCollectConsent
            self?.cmpData = UsercentricsCore.shared.getCMPData()
        } onFailure: { [weak self] error in
            // Handle non-localized error
            self?.isReady = false
            print("error while initializing sdk")
        }
    }
    
    /// Accept all the terms and update internal state if needed
    func acceptAll() {
        UsercentricsCore.shared.acceptAll(consentType: .explicit_)
        updateUsercentricsDataIfNeeded()
    }
    
    /// Deny all the terms and update internal state if needed
    func denyAll() {
        UsercentricsCore.shared.denyAll(consentType: .explicit_)
        updateUsercentricsDataIfNeeded()
    }
}
