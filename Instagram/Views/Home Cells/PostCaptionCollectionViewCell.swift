//
//  PostCaptionCollectionViewCell.swift
//  Instagram
//
//  Created by Elif İlay Eser
//

import UIKit

protocol PostCaptionCollectionViewCellDelegate:AnyObject {
    func postCaptionCollectionViewCellDidTapCaption(_ cell:PostCaptionCollectionViewCell)
}

class PostCaptionCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCaptionCollectionViewCell"
    
    weak var delegate:PostCaptionCollectionViewCellDelegate?
  
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.font = label.font.withSize(16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(label)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCaption))
        
        label.addGestureRecognizer(tap)
        
    }
                   
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    @objc func didTapCaption(){
        delegate?.postCaptionCollectionViewCellDidTapCaption(self)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = label.sizeThatFits(CGSize(width:contentView.bounds.size.width-12,
                                            height:contentView.bounds.size.height))
        label.frame = CGRect(x:12, y: 3, width: size.width, height: size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(with viewModel: PostCaptionCollectionViewCellViewModel){
        label.text = "\(viewModel.username):\(viewModel.caption ?? "")"
    }
                   
}

