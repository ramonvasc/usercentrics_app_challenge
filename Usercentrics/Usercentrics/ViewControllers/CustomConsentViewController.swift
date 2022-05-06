//
//  CustomConsentViewController.swift
//  Usercentrics_Challenge
//
//  Created by Ramon Vasconcelos on 5.5.2022.
//

import UIKit

class CustomConsentViewController: UIViewController {
    
    let viewModel = CustomConsentViewModel()
    
    private let offset = Constants.offset2x

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let scrollViewContent = UIView(frame: .zero)
        scrollViewContent.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(scrollViewContent)
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: Constants.fontSize)
        titleLabel.text = viewModel.bannerTitle
        scrollViewContent.addSubview(titleLabel)
        
        let bannerLabel = UILabel(frame: .zero)
        bannerLabel.translatesAutoresizingMaskIntoConstraints = false
        bannerLabel.numberOfLines = 0
        bannerLabel.text = viewModel.bannerDescription
        scrollViewContent.addSubview(bannerLabel)
        
        let stackViewContainer = UIView(frame: .zero)
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.backgroundColor = .lightGray
        scrollViewContent.addSubview(stackViewContainer)
        
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackViewContainer.addSubview(stackView)
        makeCategorieViewsIfNeeded(stackView: stackView)
        
        let decisionsView = UIView(frame: .zero)
        decisionsView.translatesAutoresizingMaskIntoConstraints = false
        decisionsView.backgroundColor = .white
        view.addSubview(decisionsView)
        
        let acceptButton = UIButton(type: .system)
        acceptButton.accessibilityIdentifier = "Accept"
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        var acceptButtonConfig = UIButton.Configuration.filled()
        acceptButtonConfig.title = "Accept"
        acceptButtonConfig.baseBackgroundColor = .blue
        acceptButtonConfig.titleAlignment = .center
        acceptButton.configuration = acceptButtonConfig
        acceptButton.addTarget(self, action: #selector(didTapAccept), for: .touchUpInside)
        decisionsView.addSubview(acceptButton)
        
        let declineButton = UIButton(type: .system)
        declineButton.accessibilityIdentifier = "Deny"
        declineButton.translatesAutoresizingMaskIntoConstraints = false
        var declineButtonConfig = UIButton.Configuration.filled()
        declineButtonConfig.title = "Deny"
        declineButtonConfig.baseBackgroundColor = .lightGray
        declineButtonConfig.titleAlignment = .center
        declineButton.configuration = declineButtonConfig
        declineButton.addTarget(self, action: #selector(didTapDecline), for: .touchUpInside)
        decisionsView.addSubview(declineButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: decisionsView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            scrollViewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: Constants.offset3x),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            titleLabel.bottomAnchor.constraint(equalTo: bannerLabel.topAnchor, constant: -offset),
            
            bannerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            bannerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            bannerLabel.bottomAnchor.constraint(equalTo: stackViewContainer.topAnchor, constant: -offset),
            
            stackViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackViewContainer.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: stackViewContainer.topAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: stackViewContainer.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: stackViewContainer.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: stackViewContainer.trailingAnchor),
            
            decisionsView.topAnchor.constraint(equalTo: scrollViewContent.bottomAnchor),
            decisionsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            decisionsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            decisionsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            acceptButton.topAnchor.constraint(equalTo: decisionsView.topAnchor, constant: offset),
            acceptButton.leadingAnchor.constraint(equalTo: decisionsView.leadingAnchor, constant: offset),
            acceptButton.trailingAnchor.constraint(equalTo: decisionsView.trailingAnchor, constant: -offset),
            acceptButton.bottomAnchor.constraint(equalTo: declineButton.topAnchor, constant: -offset),
            
            declineButton.centerXAnchor.constraint(equalTo: decisionsView.centerXAnchor),
            declineButton.leadingAnchor.constraint(equalTo: acceptButton.leadingAnchor),
            declineButton.trailingAnchor.constraint(equalTo: acceptButton.trailingAnchor),
            declineButton.bottomAnchor.constraint(equalTo: decisionsView.bottomAnchor, constant: -offset),
        ])
    }
    
    private func makeCategorieViewsIfNeeded(stackView: UIStackView) {
        viewModel.categories.forEach { category in
            let categoryView = CategoryView(frame: .zero, title: category.label, description: category.description_)
            stackView.addArrangedSubview(categoryView)
        }
    }
    
    @objc private func didTapAccept() {
        viewModel.acceptTerms()
        showDialog("Terms were accepted")
    }
    
    @objc private func didTapDecline() {
        viewModel.denyTerms()
        showDialog("Terms were declined")
    }
    
    private func showDialog(_ message: String) {
        let dialog = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        dialog.view.accessibilityIdentifier = "Accept/Decline Result"
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        okAction.accessibilityIdentifier = "Ok"
        
        dialog.addAction(okAction)
        
        present(dialog, animated: true, completion: nil)
    }
}
