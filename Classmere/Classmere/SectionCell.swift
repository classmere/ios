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
    
    var dayIconLabel: UILabel = UILabel.newAutoLayout()
    var instructorIconLabel: UILabel = UILabel.newAutoLayout()
    var locationIconLabel: UILabel = UILabel.newAutoLayout()
    var typeIconLabel: UILabel = UILabel.newAutoLayout()
    var enrolledIconLabel: UILabel = UILabel.newAutoLayout()
    var dateIconLabel: UILabel = UILabel.newAutoLayout()
    var crnIconLabel: UILabel = UILabel.newAutoLayout()
    
    var termLabel: UILabel = UILabel.newAutoLayout()
    var dayLabel: UILabel = UILabel.newAutoLayout()
    var instructorLabel: UILabel = UILabel.newAutoLayout()
    var locationLabel: UILabel = UILabel.newAutoLayout()
    var typeLabel: UILabel = UILabel.newAutoLayout()
    var enrolledLabel: UILabel = UILabel.newAutoLayout()
    var dateLabel: UILabel = UILabel.newAutoLayout()
    var crnLabel: UILabel = UILabel.newAutoLayout()
    
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
        
        dayIconLabel.lineBreakMode = .byTruncatingTail
        dayIconLabel.numberOfLines = 0
        dayIconLabel.textAlignment = .center
        dayIconLabel.text = EmojiFactory.emojiFromSectionProperty("Days")
        
        instructorIconLabel.lineBreakMode = .byTruncatingTail
        instructorIconLabel.numberOfLines = 0
        instructorIconLabel.textAlignment = .center
        instructorIconLabel.text = EmojiFactory.emojiFromSectionProperty("Instructor")
        
        locationIconLabel.lineBreakMode = .byTruncatingTail
        locationIconLabel.numberOfLines = 0
        locationIconLabel.textAlignment = .center
        locationIconLabel.text = EmojiFactory.emojiFromSectionProperty("Location")
        
        typeIconLabel.lineBreakMode = .byTruncatingTail
        typeIconLabel.numberOfLines = 0
        typeIconLabel.textAlignment = .center
        typeIconLabel.text = EmojiFactory.emojiFromSectionProperty("Type")
        
        enrolledIconLabel.lineBreakMode = .byTruncatingTail
        enrolledIconLabel.numberOfLines = 0
        enrolledIconLabel.textAlignment = .center
        enrolledIconLabel.text = EmojiFactory.emojiFromSectionProperty("Enrolled")
        
        dateIconLabel.lineBreakMode = .byTruncatingTail
        dateIconLabel.numberOfLines = 0
        dateIconLabel.textAlignment = .center
        dateIconLabel.text = EmojiFactory.emojiFromSectionProperty("Dates")
        
        crnIconLabel.lineBreakMode = .byTruncatingTail
        crnIconLabel.numberOfLines = 0
        crnIconLabel.textAlignment = .center
        crnIconLabel.text = EmojiFactory.emojiFromSectionProperty("CRN")
        
        termLabel.lineBreakMode = .byTruncatingTail
        termLabel.numberOfLines = 1
        termLabel.adjustsFontSizeToFitWidth = true
        termLabel.minimumScaleFactor = 0.1
        termLabel.textAlignment = .left
        termLabel.textColor = .darkGray
        termLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        
        dayLabel.lineBreakMode = .byTruncatingTail
        dayLabel.numberOfLines = 1
        dayLabel.textAlignment = .left
        dayLabel.textColor = darkColor
        dayLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        instructorLabel.lineBreakMode = .byTruncatingTail
        instructorLabel.numberOfLines = 1
        instructorLabel.textAlignment = .left
        instructorLabel.textColor = darkColor
        instructorLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        locationLabel.lineBreakMode = .byTruncatingTail
        locationLabel.numberOfLines = 1
        locationLabel.textAlignment = .left
        locationLabel.textColor = darkColor
        locationLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        typeLabel.lineBreakMode = .byTruncatingTail
        typeLabel.numberOfLines = 1
        typeLabel.textAlignment = .left
        typeLabel.textColor = darkColor
        typeLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        enrolledLabel.lineBreakMode = .byTruncatingTail
        enrolledLabel.numberOfLines = 1
        enrolledLabel.textAlignment = .left
        enrolledLabel.textColor = darkColor
        enrolledLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        dateLabel.lineBreakMode = .byTruncatingTail
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .left
        dateLabel.textColor = darkColor
        dateLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        
        crnLabel.lineBreakMode = .byTruncatingTail
        crnLabel.numberOfLines = 1
        crnLabel.textAlignment = .left
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
                self.dayIconLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.instructorIconLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.locationIconLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.typeIconLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.enrolledIconLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.dateIconLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.crnIconLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                
                self.termLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.dayLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.instructorLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.locationLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.typeLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.enrolledLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.dateLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.crnLabel.autoSetContentCompressionResistancePriority(for: .vertical)
            }
            
            termLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
            termLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
            termLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
            
            dayIconLabel.autoPinEdge(.leading, to: .leading, of: termLabel)
            dayIconLabel.autoAlignAxis(.horizontal, toSameAxisOf: termLabel, withOffset: 40)
            
            instructorIconLabel.autoPinEdge(.leading, to: .leading, of: dayIconLabel)
            instructorIconLabel.autoAlignAxis(.horizontal, toSameAxisOf: dayIconLabel, withOffset: 40)
            
            locationIconLabel.autoPinEdge(.leading, to: .leading, of: instructorIconLabel)
            locationIconLabel.autoAlignAxis(.horizontal, toSameAxisOf: instructorIconLabel, withOffset: 40)
            
            typeIconLabel.autoPinEdge(.leading, to: .leading, of: locationIconLabel)
            typeIconLabel.autoAlignAxis(.horizontal, toSameAxisOf: locationIconLabel, withOffset: 40)
            
            enrolledIconLabel.autoPinEdge(.leading, to: .leading, of: typeIconLabel)
            enrolledIconLabel.autoAlignAxis(.horizontal, toSameAxisOf: typeIconLabel, withOffset: 40)
            
            dateIconLabel.autoPinEdge(.leading, to: .leading, of: enrolledIconLabel)
            dateIconLabel.autoAlignAxis(.horizontal, toSameAxisOf: enrolledIconLabel, withOffset: 40)
            
            crnIconLabel.autoPinEdge(.leading, to: .leading, of: dateIconLabel)
            crnIconLabel.autoAlignAxis(.horizontal, toSameAxisOf: dateIconLabel, withOffset: 40)
            
            dayLabel.autoPinEdge(.leading, to: .trailing, of: dayIconLabel, withOffset: 20)
            dayLabel.autoAlignAxis(.horizontal, toSameAxisOf: dayIconLabel)
            
            instructorLabel.autoPinEdge(.leading, to: .leading, of: dayLabel)
            instructorLabel.autoAlignAxis(.horizontal, toSameAxisOf: dayLabel, withOffset: 40)
            
            locationLabel.autoPinEdge(.leading, to: .leading, of: instructorLabel)
            locationLabel.autoAlignAxis(.horizontal, toSameAxisOf: instructorLabel, withOffset: 40)
            
            typeLabel.autoPinEdge(.leading, to: .leading, of: locationLabel)
            typeLabel.autoAlignAxis(.horizontal, toSameAxisOf: locationLabel, withOffset: 40)
            
            enrolledLabel.autoPinEdge(.leading, to: .leading, of: typeLabel)
            enrolledLabel.autoAlignAxis(.horizontal, toSameAxisOf: typeLabel, withOffset: 40)
            
            dateLabel.autoPinEdge(.leading, to: .leading, of: enrolledLabel)
            dateLabel.autoAlignAxis(.horizontal, toSameAxisOf: enrolledLabel, withOffset: 40)
            
            crnLabel.autoPinEdge(.leading, to: .leading, of: dateLabel)
            crnLabel.autoAlignAxis(.horizontal, toSameAxisOf: dateLabel, withOffset: 40)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
