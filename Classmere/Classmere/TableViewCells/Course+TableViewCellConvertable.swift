import UIKit

extension Course: TableViewCellConvertable {
    static var cellType: SearchCell.Type {
        return SearchCell.self
    }

    func update(cell: SearchCell) -> SearchCell {
        cell.iconLabel.text = EmojiFactory.emojiFromCourseType(subjectCode)
        cell.titleLabel.text = title
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        return cell
    }
}
