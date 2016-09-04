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
    
    var titleLabel: UILabel = UILabel.newAutoLayoutView()
    var creditsLabel: UILabel = UILabel.newAutoLayoutView()
    var descriptionLabel: UILabel = UILabel.newAutoLayoutView()
    
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
        titleLabel.lineBreakMode = .ByTruncatingTail
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        titleLabel.textAlignment = .Left
        titleLabel.textColor = .darkGrayColor()
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        
        creditsLabel.lineBreakMode = .ByTruncatingTail
        creditsLabel.numberOfLines = 1
        creditsLabel.textAlignment = .Left
        creditsLabel.textColor = darkColor
        creditsLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        descriptionLabel.lineBreakMode = .ByTruncatingTail
        descriptionLabel.numberOfLines = 0
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.1
        descriptionLabel.textAlignment = .Left
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
                self.titleLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.creditsLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.descriptionLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
            }
            
            titleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
            titleLabel.autoPinEdgeToSuperviewEdge(.Leading, withInset: 10)
            titleLabel.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 10)
            
            creditsLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: titleLabel)
            creditsLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: titleLabel, withOffset: 20)
            
            descriptionLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: creditsLabel, withOffset: 10)
            descriptionLabel.autoPinEdgeToSuperviewEdge(.Leading, withInset: 10)
            descriptionLabel.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 10)
            
            // FIXME: Multiple constraints error here
            descriptionLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
