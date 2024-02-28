//
//  CommentCollectionViewCell.swift
//  Instagram
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {
    static let identifier = "CommentCollectionViewCell"

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        contentView.addSubview(label)

    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 5, y: 0, width: contentView.width-10, height: contentView.height)
    }

    func configure(with model: Comment) {
        label.text = "\(model.username): \(model.comment)"
    }
}
