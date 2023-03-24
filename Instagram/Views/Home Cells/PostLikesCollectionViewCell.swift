//
//  PostLikesCollectionViewCell.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 24.03.2023.
//

import UIKit

class PostLikesCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostLikesCollectionViewCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        
    }
                   
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: PostLikesCollectionViewCellViewModel){
        
    }
                   
}

