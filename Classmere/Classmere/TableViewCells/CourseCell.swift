import UIKit
import PureLayout

extension UpdatableCell where Self: CourseCell {
    func update(with model: Section) {
        termLabel.text = model.term
        iconLabel.text = EmojiFactory.emojiFromSectionType(model.type)

        // TODO: Show all meeting times!
        if let meetingTimes = model.meetingTimes, let meetingTime = meetingTimes.first {
            let days = meetingTime.days ?? "No meeting day specified"
            let startTime = meetingTime.startTime ?? "No start time specified"
            let endTime = meetingTime.endTime ?? "No end time specified"
            let building = meetingTime.buildingCode ?? "No building specified"
            let roomNumber = meetingTime.roomNumber == nil ? String(describing: meetingTime.roomNumber) : ""
            timeLabel.text = "\(days) \(startTime) - \(endTime)"
            locationLabel.text = "\(building) \(roomNumber)"
        }

        instructorLabel.text = model.instructor
        typeLabel.text = model.type

        updateConstraintsIfNeeded()
    }
}

extension CourseCell: UpdatableCell {}

class CourseCell: UITableViewCell {

    let darkColor: UIColor = UIColor(red: 0.27, green: 0.27, blue: 0.27, alpha: 1.0)
    let separatorColor: UIColor = UIColor(red: 0.783922, green: 0.780392, blue: 0.8, alpha: 1.0)

    var didSetupConstraints = false

    var termLabel: UILabel = UILabel.newAutoLayout()
    var iconLabel: UILabel = UILabel.newAutoLayout()
    var timeLabel: UILabel = UILabel.newAutoLayout()
    var instructorLabel: UILabel = UILabel.newAutoLayout()
    var locationLabel: UILabel = UILabel.newAutoLayout()
    var typeLabel: UILabel = UILabel.newAutoLayout()
    var verticalSeparator: UIView = UIView.newAutoLayout()

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
        self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

        termLabel.lineBreakMode = .byTruncatingTail
        termLabel.numberOfLines = 1
        termLabel.textAlignment = .left
        termLabel.textColor = .darkGray
        termLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 14)

        iconLabel.lineBreakMode = .byTruncatingTail
        iconLabel.numberOfLines = 0
        iconLabel.textAlignment = .center

        timeLabel.lineBreakMode = .byTruncatingTail
        timeLabel.numberOfLines = 1
        timeLabel.textAlignment = .left
        timeLabel.textColor = darkColor
        timeLabel.font = UIFont(name: "HelveticaNeue", size: 13)

        instructorLabel.lineBreakMode = .byTruncatingTail
        instructorLabel.numberOfLines = 1
        instructorLabel.textAlignment = .left
        instructorLabel.textColor = darkColor
        instructorLabel.font = UIFont(name: "HelveticaNeue", size: 13)

        verticalSeparator.backgroundColor = separatorColor

        locationLabel.lineBreakMode = .byTruncatingTail
        locationLabel.numberOfLines = 1
        locationLabel.textAlignment = .left
        locationLabel.textColor = darkColor
        locationLabel.font = UIFont(name: "HelveticaNeue", size: 13)

        typeLabel.lineBreakMode = .byClipping
        typeLabel.numberOfLines = 1
        typeLabel.textAlignment = .left
        typeLabel.textColor = darkColor
        typeLabel.font = UIFont(name: "HelveticaNeue", size: 13)

        contentView.addSubview(termLabel)
        contentView.addSubview(iconLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(instructorLabel)
        contentView.addSubview(verticalSeparator)
        contentView.addSubview(locationLabel)
        contentView.addSubview(typeLabel)
    }

    // MARK: - Layout

    override func updateConstraints() {
        if !didSetupConstraints {
            NSLayoutConstraint.autoSetPriority(UILayoutPriority.required) {
                self.termLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.iconLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.timeLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.instructorLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.locationLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.typeLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.verticalSeparator.autoSetContentCompressionResistancePriority(for: .vertical)
            }

            termLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
            termLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)

            iconLabel.autoPinEdge(.leading, to: .leading, of: termLabel)
            iconLabel.autoAlignAxis(.horizontal, toSameAxisOf: termLabel, withOffset: 45)

            timeLabel.autoPinEdge(.top, to: .bottom, of: termLabel, withOffset: 10)
            timeLabel.autoPinEdge(.leading, to: .trailing, of: iconLabel, withOffset: 10)

            instructorLabel.autoPinEdge(.leading, to: .leading, of: timeLabel)
            instructorLabel.autoAlignAxis(.horizontal, toSameAxisOf: timeLabel, withOffset: 25)

            verticalSeparator.autoSetDimensions(to: CGSize(width: 1, height: 44))
            verticalSeparator.autoPinEdge(toSuperviewEdge: .leading, withInset: 220)
            verticalSeparator.autoPinEdge(toSuperviewEdge: .top, withInset: 40)

            locationLabel.autoPinEdge(.leading, to: .trailing, of: verticalSeparator, withOffset: 10)
            locationLabel.autoAlignAxis(.horizontal, toSameAxisOf: timeLabel)

            typeLabel.autoPinEdge(.leading, to: .trailing, of: verticalSeparator, withOffset: 10)
            typeLabel.autoAlignAxis(.horizontal, toSameAxisOf: instructorLabel)

            didSetupConstraints = true
        }

        super.updateConstraints()
    }
}
