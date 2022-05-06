//
//  ConsentChoiceViewController.swift
//  Usercentrics
//
//  Created by Ramon Vasconcelos on 5.5.2022.
//

import UIKit
import UsercentricsUI

class ConsentChoiceViewController: UIViewController {
    
    private let usercentricsManager = UsercentricsManager.shared
    
    private let offset = Constants.offset2x

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let defaultConsentButton = UIButton(type: .system)
        defaultConsentButton.accessibilityIdentifier = "Default UI"
        defaultConsentButton.translatesAutoresizingMaskIntoConstraints = false
        var defaultConsentButtonConfig = UIButton.Configuration.filled()
        defaultConsentButtonConfig.title = "Show Usercentrics UI"
        defaultConsentButtonConfig.baseBackgroundColor = .blue
        defaultConsentButtonConfig.titleAlignment = .center
        defaultConsentButton.configuration = defaultConsentButtonConfig
        defaultConsentButton.addTarget(self, action: #selector(didTapDefaultConsent), for: .touchUpInside)
        view.addSubview(defaultConsentButton)
        
        let customConsentButton = UIButton(frame: .zero)
        customConsentButton.accessibilityIdentifier = "Custom UI"
        customConsentButton.translatesAutoresizingMaskIntoConstraints = false
        var customConsentButtonConfig = UIButton.Configuration.filled()
        customConsentButtonConfig.title = "Show Own UI"
        customConsentButtonConfig.baseBackgroundColor = .blue
        customConsentButtonConfig.titleAlignment = .center
        customConsentButton.configuration = customConsentButtonConfig
        customConsentButton.addTarget(self, action: #selector(didTapCustomConsent), for: .touchUpInside)
        view.addSubview(customConsentButton)
        
        NSLayoutConstraint.activate([
            defaultConsentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            customConsentButton.topAnchor.constraint(equalTo: defaultConsentButton.bottomAnchor, constant: offset),
            customConsentButton.leadingAnchor.constraint(equalTo: defaultConsentButton.leadingAnchor),
            customConsentButton.trailingAnchor.constraint(equalTo: defaultConsentButton.trailingAnchor),
            customConsentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -offset)
        ])
    }
    
    @objc private func didTapDefaultConsent() {
        if canShowConsent() {
            let banner = UsercentricsBanner()
            banner.showSecondLayer(hostView: self) { [weak self] userResponse in
                // Consent was given, either store this locally to unlock some
                // app feature or send to remote server to register the consent.
                print("did get consent")
                self?.usercentricsManager.updateUsercentricsDataIfNeeded()
            }
        }
    }
        
    @objc private func didTapCustomConsent() {
        if canShowConsent() {
            let customConsentViewController = CustomConsentViewController()
            present(customConsentViewController, animated: true, completion: nil)
        }
    }
    
    private func showErrorDialog(_ message: String) {
        let dialog = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        dialog.view.accessibilityIdentifier = "SDK Error Dialog"
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        okAction.accessibilityIdentifier = "Ok"
        dialog.addAction(okAction)
        
        present(dialog, animated: true, completion: nil)
    }
    
    private func canShowConsent() -> Bool {
        if usercentricsManager.isReady {
            if usercentricsManager.shouldCollectConsent {
                return true
            } else {
                showErrorDialog("Consent has been collected already.")
                return false
            }
        } else {
            showErrorDialog("SDK is not ready yet, try again later.")
            return false
        }
    }
}
