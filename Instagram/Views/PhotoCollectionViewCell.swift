//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 15.02.2024.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "photocell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .label
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
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
    
    func configure(with image: UIImage?){
        imageView.image = image
    }
    
    func configure(with url: URL?) {
        imageView.sd_setImage(with: url, completed: nil)
    }
}
