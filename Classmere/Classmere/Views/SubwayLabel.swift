import UIKit
import ChameleonFramework
import PureLayout

class SubwayLabel: UIView {

    var text: String? {
        get {
            return textLabel.text
        }
        set(newText) {
            textLabel.text = newText
        }
    }

    var color: Theme.Color {
        didSet {
            backgroundColor = color.uicolor
        }
    }

    let textLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        self.color = .blue
        super.init(frame: frame)
        setUp(size: frame.size)
    }

    convenience init(text: String, color: Theme.Color) {
        self.init(frame: .zero)
        self.text = text
        self.color = color
        setUp(size: frame.size)
    }

    private func setUp(size: CGSize) {
        addSubview(textLabel)
        textLabel.baselineAdjustment = .alignCenters
        textLabel.textColor = .white
        textLabel.minimumScaleFactor = 1 / CGFloat.greatestFiniteMagnitude
        textLabel.numberOfLines = 1
        textLabel.adjustsFontSizeToFitWidth = true
    }

    override func layoutSubviews() {
        let insetSize = frame.width * 0.2
        textLabel.font = UIFont.boldSystemFont(ofSize: frame.width)
        textLabel.font = UIFont.systemFont(ofSize: frame.width, weight: .heavy)
        textLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0,
                                                                  left: insetSize,
                                                                  bottom: 0,
                                                                  right: insetSize))
        layer.cornerRadius = frame.width / 2.0
    }

}
