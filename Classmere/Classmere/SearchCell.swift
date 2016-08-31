//
//  SearchCell.swift
//  Classmere
//
//  Created by Brandon Lee on 8/16/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import PureLayout

class SearchCell: UITableViewCell {
    
    var didSetupConstraints = false
    
    var iconLabel: UILabel = UILabel.newAutoLayoutView()
    var titleLabel: UILabel = UILabel.newAutoLayoutView()

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
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        iconLabel.lineBreakMode = .ByTruncatingTail
        iconLabel.numberOfLines = 0
        iconLabel.textAlignment = .Left
        iconLabel.textColor = .darkGrayColor()
        
        titleLabel.lineBreakMode = .ByTruncatingTail
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .Left
        titleLabel.textColor = .blackColor()
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconLabel)
    }
    
    // MARK: - Layout
    
    override func updateConstraints() {
        if !didSetupConstraints {
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityRequired) {
                self.titleLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.iconLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
            }
            
            iconLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
            iconLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
            iconLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 10)
            
            titleLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: iconLabel)
            titleLabel.autoPinEdge(.Leading, toEdge: .Trailing, ofView: iconLabel, withOffset: 10)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
