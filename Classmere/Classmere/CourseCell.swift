//
//  CourseCell.swift
//  Classmere
//
//  Created by Brandon Lee on 8/27/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import PureLayout

class CourseCell: UITableViewCell {
    
    let darkColor: UIColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0)
    
    var didSetupConstraints = false
    
    var termLabel: UILabel = UILabel.newAutoLayoutView()
    var iconLabel: UILabel = UILabel.newAutoLayoutView()
    var timeLabel: UILabel = UILabel.newAutoLayoutView()
    var instructorLabel: UILabel = UILabel.newAutoLayoutView()
    var locationLabel: UILabel = UILabel.newAutoLayoutView()
    var typeLabel: UILabel = UILabel.newAutoLayoutView()
    var verticalSeparator: UIView = UIView.newAutoLayoutView()
    
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
        
        termLabel.lineBreakMode = .ByTruncatingTail
        termLabel.numberOfLines = 1
        termLabel.textAlignment = .Left
        termLabel.textColor = .darkGrayColor()
        termLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        termLabel.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.5)
        
        iconLabel.lineBreakMode = .ByTruncatingTail
        iconLabel.numberOfLines = 0
        iconLabel.textAlignment = .Center
        iconLabel.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.5)
        
        timeLabel.lineBreakMode = .ByTruncatingTail
        timeLabel.numberOfLines = 1
        timeLabel.textAlignment = .Left
        timeLabel.textColor = darkColor
        timeLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        timeLabel.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.5)
        
        instructorLabel.lineBreakMode = .ByTruncatingTail
        instructorLabel.numberOfLines = 1
        instructorLabel.textAlignment = .Left
        instructorLabel.textColor = darkColor
        timeLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        instructorLabel.backgroundColor = UIColor.yellowColor().colorWithAlphaComponent(0.5)
        
        locationLabel.lineBreakMode = .ByTruncatingTail
        locationLabel.numberOfLines = 1
        locationLabel.textAlignment = .Left
        locationLabel.textColor = darkColor
        timeLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        locationLabel.backgroundColor = UIColor.orangeColor().colorWithAlphaComponent(0.5)
        
        typeLabel.lineBreakMode = .ByClipping
        typeLabel.numberOfLines = 1
        typeLabel.textAlignment = .Left
        typeLabel.textColor = darkColor
        timeLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        typeLabel.backgroundColor = UIColor.purpleColor().colorWithAlphaComponent(0.5)
        
        verticalSeparator = UIView(frame: CGRectMake(80, 0, 1, 44))
        verticalSeparator.backgroundColor = darkColor

        contentView.addSubview(termLabel)
        contentView.addSubview(iconLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(instructorLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(verticalSeparator)
    }
    
    // MARK: - Layout
    
    override func updateConstraints() {
        if !didSetupConstraints {
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityRequired) {
                self.termLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.iconLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.timeLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.instructorLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.locationLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.typeLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.verticalSeparator.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
            }
            
            termLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 10.0)
            termLabel.autoPinEdgeToSuperviewEdge(.Leading, withInset: 10.0)
            
            iconLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: termLabel)
            iconLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: termLabel, withOffset: 45.0)
            
            timeLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: termLabel, withOffset: 10.0)
            timeLabel.autoPinEdge(.Leading, toEdge: .Trailing, ofView: iconLabel, withOffset: 10.0)
            
            instructorLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: timeLabel)
            instructorLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: timeLabel, withOffset: 25.0)
            
//            verticalSeparator.autoPinEdgeToSuperviewEdge(.Leading, withInset: 100.0)
            verticalSeparator.autoPinEdge(.Left, toEdge: .Right, ofView: instructorLabel, withOffset: 50.0)
            
            locationLabel.autoPinEdge(.Leading, toEdge: .Trailing, ofView: timeLabel, withOffset: 50.0)
            locationLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: timeLabel)
            
            typeLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: locationLabel)
            typeLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: instructorLabel)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
