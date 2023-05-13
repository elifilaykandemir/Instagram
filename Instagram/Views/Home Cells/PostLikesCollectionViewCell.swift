//
//  PostLikesCollectionViewCell.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 24.03.2023.
//

import UIKit

protocol PostLikesCollectionViewCellDelegate:AnyObject{
    func postLikesCollectionViewCellDidTapLikeCount(_ cell:PostLikesCollectionViewCell)
}
class PostLikesCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostLikesCollectionViewCell"
    
    weak var delegate:PostLikesCollectionViewCellDelegate?
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(label)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLikesLabel))
        label.addGestureRecognizer(tap)
        
    }
                   
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: 0, width: contentView.width-12, height: contentView.height)
    }
    
    @objc func didTapLikesLabel(){
        delegate?.postLikesCollectionViewCellDidTapLikeCount(self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(with viewModel: PostLikesCollectionViewCellViewModel){
        let users = viewModel.likers
        label.text = "\(users.count) Likes"
    }
                   
}

