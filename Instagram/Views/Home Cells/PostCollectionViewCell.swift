//
//  PostCollectionViewCell.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 24.03.2023.
//

import UIKit
import SDWebImage

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        
    }
                   
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: PostCollectionViewCellViewModel){
        imageView.sd_setImage(with: viewModel.postURL, completed: nil)
    }
                   
}

