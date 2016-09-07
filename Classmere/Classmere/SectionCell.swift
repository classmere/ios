//
//  SectionCell.swift
//  Classmere
//
//  Created by Brandon Lee on 9/5/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import PureLayout

class SectionCell: UITableViewCell {

    let darkColor: UIColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0)
    
    var didSetupConstraints = false
    
    var dayIconLabel: UILabel = UILabel.newAutoLayoutView()
    var instructorIconLabel: UILabel = UILabel.newAutoLayoutView()
    var locationIconLabel: UILabel = UILabel.newAutoLayoutView()
    var typeIconLabel: UILabel = UILabel.newAutoLayoutView()
    var enrolledIconLabel: UILabel = UILabel.newAutoLayoutView()
    var dateIconLabel: UILabel = UILabel.newAutoLayoutView()
    var crnIconLabel: UILabel = UILabel.newAutoLayoutView()
    
    var termLabel: UILabel = UILabel.newAutoLayoutView()
    var dayLabel: UILabel = UILabel.newAutoLayoutView()
    var instructorLabel: UILabel = UILabel.newAutoLayoutView()
    var locationLabel: UILabel = UILabel.newAutoLayoutView()
    var typeLabel: UILabel = UILabel.newAutoLayoutView()
    var enrolledLabel: UILabel = UILabel.newAutoLayoutView()
    var dateLabel: UILabel = UILabel.newAutoLayoutView()
    var crnLabel: UILabel = UILabel.newAutoLayoutView()
    
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
        
        dayIconLabel.lineBreakMode = .ByTruncatingTail
        dayIconLabel.numberOfLines = 0
        dayIconLabel.textAlignment = .Center
        dayIconLabel.text = EmojiFactory.emojiFromSectionProperty("Days")
        
        instructorIconLabel.lineBreakMode = .ByTruncatingTail
        instructorIconLabel.numberOfLines = 0
        instructorIconLabel.textAlignment = .Center
        instructorIconLabel.text = EmojiFactory.emojiFromSectionProperty("Instructor")
        
        locationIconLabel.lineBreakMode = .ByTruncatingTail
        locationIconLabel.numberOfLines = 0
        locationIconLabel.textAlignment = .Center
        locationIconLabel.text = EmojiFactory.emojiFromSectionProperty("Location")
        
        typeIconLabel.lineBreakMode = .ByTruncatingTail
        typeIconLabel.numberOfLines = 0
        typeIconLabel.textAlignment = .Center
        typeIconLabel.text = EmojiFactory.emojiFromSectionProperty("Type")
        
        enrolledIconLabel.lineBreakMode = .ByTruncatingTail
        enrolledIconLabel.numberOfLines = 0
        enrolledIconLabel.textAlignment = .Center
        enrolledIconLabel.text = EmojiFactory.emojiFromSectionProperty("Enrolled")
        
        dateIconLabel.lineBreakMode = .ByTruncatingTail
        dateIconLabel.numberOfLines = 0
        dateIconLabel.textAlignment = .Center
        dateIconLabel.text = EmojiFactory.emojiFromSectionProperty("Dates")
        
        crnIconLabel.lineBreakMode = .ByTruncatingTail
        crnIconLabel.numberOfLines = 0
        crnIconLabel.textAlignment = .Center
        crnIconLabel.text = EmojiFactory.emojiFromSectionProperty("CRN")
        
        termLabel.lineBreakMode = .ByTruncatingTail
        termLabel.numberOfLines = 1
        termLabel.adjustsFontSizeToFitWidth = true
        termLabel.minimumScaleFactor = 0.1
        termLabel.textAlignment = .Left
        termLabel.textColor = .darkGrayColor()
        termLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        
        dayLabel.lineBreakMode = .ByTruncatingTail
        dayLabel.numberOfLines = 1
        dayLabel.textAlignment = .Left
        dayLabel.textColor = darkColor
        dayLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        instructorLabel.lineBreakMode = .ByTruncatingTail
        instructorLabel.numberOfLines = 1
        instructorLabel.textAlignment = .Left
        instructorLabel.textColor = darkColor
        instructorLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        locationLabel.lineBreakMode = .ByTruncatingTail
        locationLabel.numberOfLines = 1
        locationLabel.textAlignment = .Left
        locationLabel.textColor = darkColor
        locationLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        typeLabel.lineBreakMode = .ByTruncatingTail
        typeLabel.numberOfLines = 1
        typeLabel.textAlignment = .Left
        typeLabel.textColor = darkColor
        typeLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        enrolledLabel.lineBreakMode = .ByTruncatingTail
        enrolledLabel.numberOfLines = 1
        enrolledLabel.textAlignment = .Left
        enrolledLabel.textColor = darkColor
        enrolledLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        dateLabel.lineBreakMode = .ByTruncatingTail
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .Left
        dateLabel.textColor = darkColor
        dateLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        crnLabel.lineBreakMode = .ByTruncatingTail
        crnLabel.numberOfLines = 1
        crnLabel.textAlignment = .Left
        crnLabel.textColor = darkColor
        crnLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        contentView.addSubview(dayIconLabel)
        contentView.addSubview(instructorIconLabel)
        contentView.addSubview(locationIconLabel)
        contentView.addSubview(typeIconLabel)
        contentView.addSubview(enrolledIconLabel)
        contentView.addSubview(dateIconLabel)
        contentView.addSubview(crnIconLabel)
        
        contentView.addSubview(termLabel)
        contentView.addSubview(dayLabel)
        contentView.addSubview(instructorLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(enrolledLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(crnLabel)
    }
    
    // MARK: - Layout
    
    override func updateConstraints() {
        if !didSetupConstraints {
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityRequired) {
                self.dayIconLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.instructorIconLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.locationIconLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.typeIconLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.enrolledIconLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.dateIconLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.crnIconLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                
                self.termLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.dayLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.instructorLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.locationLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.typeLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.enrolledLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.dateLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
                self.crnLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
            }
            
            termLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
            termLabel.autoPinEdgeToSuperviewEdge(.Leading, withInset: 10)
            termLabel.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 10)
            
            dayIconLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: termLabel)
            dayIconLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: termLabel, withOffset: 40)
            
            instructorIconLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: dayIconLabel)
            instructorIconLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: dayIconLabel, withOffset: 40)
            
            locationIconLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: instructorIconLabel)
            locationIconLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: instructorIconLabel, withOffset: 40)
            
            typeIconLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: locationIconLabel)
            typeIconLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: locationIconLabel, withOffset: 40)
            
            enrolledIconLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: typeIconLabel)
            enrolledIconLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: typeIconLabel, withOffset: 40)
            
            dateIconLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: enrolledIconLabel)
            dateIconLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: enrolledIconLabel, withOffset: 40)
            
            crnIconLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: dateIconLabel)
            crnIconLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: dateIconLabel, withOffset: 40)
            
            dayLabel.autoPinEdge(.Leading, toEdge: .Trailing, ofView: dayIconLabel, withOffset: 20)
            dayLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: dayIconLabel)
            
            instructorLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: dayLabel)
            instructorLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: dayLabel, withOffset: 40)
            
            locationLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: instructorLabel)
            locationLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: instructorLabel, withOffset: 40)
            
            typeLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: locationLabel)
            typeLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: locationLabel, withOffset: 40)
            
            enrolledLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: typeLabel)
            enrolledLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: typeLabel, withOffset: 40)
            
            dateLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: enrolledLabel)
            dateLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: enrolledLabel, withOffset: 40)
            
            crnLabel.autoPinEdge(.Leading, toEdge: .Leading, ofView: dateLabel)
            crnLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: dateLabel, withOffset: 40)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
