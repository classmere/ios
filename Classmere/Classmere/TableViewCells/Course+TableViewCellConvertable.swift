import UIKit

extension TableViewCellConvertable where Cell: CourseCell, Self: CourseType { }

extension TableViewCellConvertable where Cell: SearchCell, Self: CourseType {
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

extension Course: TableViewCellConvertable {
    typealias Model = Course
}
