//
//  CategoryView.swift
//  Usercentrics_Challenge
//
//  Created by Ramon Vasconcelos on 5.5.2022.
//

import UIKit

class CategoryView: UIView {
    
    private let offset = Constants.offset
    
    init(frame: CGRect, title: String?, description: String?) {
        super.init(frame: frame)
        
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.cgColor
        addSubview(contentView)
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: Constants.fontSize)
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = description
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: offset),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: offset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -offset),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
