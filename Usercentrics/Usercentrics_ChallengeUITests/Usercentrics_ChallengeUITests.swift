//
//  Usercentrics_ChallengeUITests.swift
//  Usercentrics_ChallengeUITests
//
//  Created by Ramon Vasconcelos on 6.5.2022.
//

import XCTest

class Usercentrics_ChallengeUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.uninstall()
    }
    
    func testDefaultUI() throws {
        XCTAssertTrue(app.buttons["Default UI"].exists)
        XCTAssertTrue(app.buttons["Custom UI"].exists)
        
        app.buttons["Default UI"].tap()
        
        
        if app.buttons["Accept All"].waitForExistence(timeout: TimeInterval(2)) {
            XCTAssertTrue(app.buttons["Accept All"].exists)
            XCTAssertTrue(app.buttons["Deny"].exists)
            XCTAssertTrue(app.buttons["Save Services"].exists)
        } else {
            XCTFail("Failed to find control buttons")
        }
        
        app.buttons["Accept All"].tap()
        
        XCTAssertTrue(app.buttons["Default UI"].exists)
        XCTAssertTrue(app.buttons["Custom UI"].exists)
                
        app.buttons["Default UI"].tap()
        
        XCTAssertTrue(app.alerts["SDK Error Dialog"].label == "Consent has been collected already.")
        
        app.alerts["SDK Error Dialog"].scrollViews.otherElements.buttons["Ok"].tap()

        XCTAssertTrue(app.buttons["Default UI"].exists)
        XCTAssertTrue(app.buttons["Custom UI"].exists)
    }
    
    func testCustomUI() throws {
        XCTAssertTrue(app.buttons["Default UI"].exists)
        XCTAssertTrue(app.buttons["Custom UI"].exists)
        
        app.buttons["Custom UI"].tap()
        
        XCTAssertTrue(app.buttons["Accept"].exists)
        XCTAssertTrue(app.buttons["Deny"].exists)
        app.buttons["Accept"].tap()
        
        XCTAssertTrue(app.alerts["Accept/Decline Result"].exists)
        app.alerts["Terms were accepted"].scrollViews.otherElements.buttons["Ok"].tap()
        
        XCTAssertTrue(app.buttons["Default UI"].exists)
        XCTAssertTrue(app.buttons["Custom UI"].exists)
        
        app.buttons["Custom UI"].tap()
        
        XCTAssertTrue(app.alerts["SDK Error Dialog"].label == "Consent has been collected already.")
        
        app.alerts["SDK Error Dialog"].scrollViews.otherElements.buttons["Ok"].tap()

        XCTAssertTrue(app.buttons["Default UI"].exists)
        XCTAssertTrue(app.buttons["Custom UI"].exists)
    }
}

extension XCUIApplication {
    func uninstall(name: String? = nil) {
        self.terminate()

        let timeout = TimeInterval(5)
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

        let appName: String
        if let name = name {
            appName = name
        } else {
            let uiTestRunnerName = Bundle.main.infoDictionary?["CFBundleName"] as! String
            appName = uiTestRunnerName.replacingOccurrences(of: "UITests-Runner", with: "")
        }

        /// use `firstMatch` because icon may appear in iPad dock
        let appIcon = springboard.icons[appName].firstMatch
        if appIcon.waitForExistence(timeout: timeout) {
            appIcon.press(forDuration: 2)
        } else {
            XCTFail("Failed to find app icon named \(appName)")
        }

        let removeAppButton = springboard.buttons["Remove App"]
        if removeAppButton.waitForExistence(timeout: timeout) {
            removeAppButton.tap()
        } else {
            XCTFail("Failed to find 'Remove App', please change the device language English")
        }

        let deleteAppButton = springboard.alerts.buttons["Delete App"]
        if deleteAppButton.waitForExistence(timeout: timeout) {
            deleteAppButton.tap()
        } else {
            XCTFail("Failed to find 'Delete App', please change the device language English")
        }

        let finalDeleteButton = springboard.alerts.buttons["Delete"]
        if finalDeleteButton.waitForExistence(timeout: timeout) {
            finalDeleteButton.tap()
        } else {
            XCTFail("Failed to find 'Delete', please change the device language English")
        }
    }
}
