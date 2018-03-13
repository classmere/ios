import UIKit
import PureLayout

extension UpdatableCell where Self: SectionCell {
    func update(with model: Section) {
        termLabel.text = Utilities.parseTerm(model.term)
        if let meetingTime = model.meetingTimes?.first {
            let days = meetingTime.days ?? "No meeting times specified"
            let building = meetingTime.buildingCode ?? "No location specified"
            let roomNumber = meetingTime.roomNumber == nil ? String(describing: meetingTime.roomNumber) : ""

            if let startTime = meetingTime.startTime, let endTime = meetingTime.endTime {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                dateFormatter.dateStyle = .none
                dateFormatter.timeStyle = .short

                let startTime = dateFormatter.string(from: startTime)
                let endTime = dateFormatter.string(from: endTime)
                dayLabel.text = "\(days) \(startTime) - \(endTime)"
            } else {
                dayLabel.text = days
            }

            locationLabel.text = "\(building) \(roomNumber)"
        } else {
            dayLabel.text = "No meeting times specified"
            locationLabel.text = "No location specified"
        }

        instructorLabel.text = model.instructor
        typeLabel.text = model.type

        if let currentlyEnrolled = model.enrollmentCurrent, let enrollmentCapacity = model.enrollmentCapacity {
            let spotsLeft = enrollmentCapacity - currentlyEnrolled
            enrolledLabel.text = "\(currentlyEnrolled) student(s) enrolled, \(spotsLeft) spots left"
        }

        if let startDate = model.startDate, let endDate = model.endDate {
            dateLabel.text = "\(startDate) - \(endDate)"
        }

        if let crn = model.crn {
            crnLabel.text = "CRN: \(crn)"
        }

        selectionStyle = .none
        updateConstraintsIfNeeded()
    }
}

extension SectionCell: UpdatableCell {}

final class SectionCell: UITableViewCell {

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
        let iconLabels = [
            dayIconLabel,
            instructorIconLabel,
            locationIconLabel,
            typeIconLabel,
            enrolledIconLabel,
            dateIconLabel,
            crnIconLabel
        ]

        let infoLabels = [
            dayLabel,
            instructorLabel,
            locationLabel,
            typeLabel,
            enrolledLabel,
            dateLabel,
            crnLabel
        ]

        let labelTitles = [
            "Days",
            "Instructor",
            "Location",
            "Type",
            "Enrolled",
            "Dates",
            "CRN"
        ]

        for iconLabel in zip(iconLabels, labelTitles) {
            iconLabel.0.lineBreakMode = .byTruncatingTail
            iconLabel.0.numberOfLines = 0
            iconLabel.0.textAlignment = .center
            iconLabel.0.text = EmojiFactory.emojiFromSectionProperty(iconLabel.1)
            contentView.addSubview(iconLabel.0)
        }

        for infoLabel in infoLabels {
            infoLabel.lineBreakMode = .byTruncatingTail
            infoLabel.numberOfLines = 1
            infoLabel.textAlignment = .left
            infoLabel.textColor = Theme.Color.dark.uicolor
            infoLabel.font = UIFont(name: "HelveticaNeue", size: 13)
            contentView.addSubview(infoLabel)
        }

        termLabel.lineBreakMode = .byTruncatingTail
        termLabel.numberOfLines = 1
        termLabel.adjustsFontSizeToFitWidth = true
        termLabel.minimumScaleFactor = 0.1
        termLabel.textAlignment = .left
        termLabel.textColor = .darkGray
        termLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        contentView.addSubview(termLabel)
    }

    // MARK: - Layout

    override func updateConstraints() {
        if !didSetupConstraints {
            NSLayoutConstraint.autoSetPriority(UILayoutPriority.required) {
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
