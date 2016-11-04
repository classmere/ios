//
//  CourseDetailsCell.swift
//  Classmere
//
//  Created by Brandon Lee on 8/30/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import PureLayout

class CourseDetailsCell: UITableViewCell {

    let darkColor: UIColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0)
    
    var didSetupConstraints = false
    
    var titleLabel: UILabel = UILabel.newAutoLayout()
    var creditsLabel: UILabel = UILabel.newAutoLayout()
    var descriptionLabel: UILabel = UILabel.newAutoLayout()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    // MARK: - Setup
    
    func setupViews() {
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        titleLabel.textAlignment = .left
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        
        creditsLabel.lineBreakMode = .byTruncatingTail
        creditsLabel.numberOfLines = 1
        creditsLabel.textAlignment = .left
        creditsLabel.textColor = darkColor
        creditsLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.numberOfLines = 0
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.1
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = darkColor
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(creditsLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    // MARK: - Layout
    
    override func updateConstraints() {
        if !didSetupConstraints {
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityRequired) {
                self.titleLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.creditsLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.descriptionLabel.autoSetContentCompressionResistancePriority(for: .vertical)
            }
            
            titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
            titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
            titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
            
            creditsLabel.autoPinEdge(.leading, to: .leading, of: titleLabel)
            creditsLabel.autoAlignAxis(.horizontal, toSameAxisOf: titleLabel, withOffset: 20)
            
            descriptionLabel.autoPinEdge(.top, to: .bottom, of: creditsLabel, withOffset: 10)
            descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
            descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
            
            // FIXME: Multiple constraints error here
            descriptionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
