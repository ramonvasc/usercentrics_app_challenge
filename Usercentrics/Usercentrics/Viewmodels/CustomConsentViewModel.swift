//
//  CustomConsentViewModel.swift
//  Usercentrics_Challenge
//
//  Created by Ramon Vasconcelos on 5.5.2022.
//

import Foundation
import Usercentrics

class CustomConsentViewModel {
    
    let usercentricsManager = UsercentricsManager.shared
    
    var bannerTitle: String {
        usercentricsManager.cmpData?.settings.labels.firstLayerTitle ?? ""
    }
    
    var bannerDescription: String {
        usercentricsManager.cmpData?.settings.labels.headerModal ?? ""
    }
    
    var categories: [UsercentricsCategory] {
        usercentricsManager.cmpData?.categories ?? []
    }
    
    func acceptTerms() {
        usercentricsManager.acceptAll()
    }
    
    func denyTerms() {
        usercentricsManager.denyAll()
    }
}
