import UIKit
import PureLayout

class SearchCell: UITableViewCell {

    var didSetupConstraints = false

    var iconLabel: UILabel = UILabel.newAutoLayout()
    var titleLabel: UILabel = UILabel.newAutoLayout()

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

        iconLabel.lineBreakMode = .byTruncatingTail
        iconLabel.numberOfLines = 1
        iconLabel.textAlignment = .left
        iconLabel.textColor = .darkGray

        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.1
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 13)

        contentView.addSubview(iconLabel)
        contentView.addSubview(titleLabel)
    }

    // MARK: - Layout

    override func updateConstraints() {
        if !didSetupConstraints {
            NSLayoutConstraint.autoSetPriority(UILayoutPriority.required) {
                self.titleLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.iconLabel.autoSetContentCompressionResistancePriority(for: .vertical)
            }

            iconLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
            iconLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
            iconLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)

            titleLabel.autoAlignAxis(.horizontal, toSameAxisOf: iconLabel)
            titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 40)
            titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)

            didSetupConstraints = true
        }

        super.updateConstraints()
    }
}
