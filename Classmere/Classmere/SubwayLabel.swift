import UIKit
import ChameleonFramework
import PureLayout

class SubwayLabel: UIView {

    let textLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp(color: .clear)
    }

    convenience init(text: String, color: UIColor) {
        self.init(frame: .zero)
        textLabel.text = text
        backgroundColor = color
        setUp(color: color)
    }

    private func setUp(color: UIColor) {
        addSubview(textLabel)
        let fontSize: CGFloat = 100.0
        textLabel.baselineAdjustment = .alignCenters
        textLabel.textColor = ContrastColorOf(color, returnFlat: true)
        textLabel.textColor = .white
        textLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
        textLabel.numberOfLines = 1
        textLabel.minimumScaleFactor = 1 / fontSize
        textLabel.adjustsFontSizeToFitWidth = true
    }

    override func layoutSubviews() {
        let insetSize = frame.width * 0.1
        textLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: insetSize,
                                                                  left: insetSize,
                                                                  bottom: insetSize,
                                                                  right: insetSize))
        layer.cornerRadius = frame.width / 2.0
    }

}
