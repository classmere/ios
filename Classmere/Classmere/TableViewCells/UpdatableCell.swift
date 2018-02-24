import UIKit

protocol UpdatableCell: class {
    associatedtype Model
    func update(with model: Model)
}

extension UpdatableCell {
    static var cellIdentifier: String {
        return String(describing: type(of: self))
    }
}
