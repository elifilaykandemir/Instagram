//
//  PostActionCollectionViewCell.swift
//  Instagram
//
//  Created by Elif İlay Eser
//

import UIKit

protocol PostActionCollectionViewCellDelegate : AnyObject {
    func postActionCollectionViewCellDidTapLiked(_ cell:PostActionCollectionViewCell, isLiked:Bool)
    func postActionCollectionViewCellDidTapComment(_ cell:PostActionCollectionViewCell)
    func postActionCollectionViewCellDidTapShare(_ cell:PostActionCollectionViewCell)
}

class PostActionCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostActionCollectionViewCell"
    
    weak var delegate: PostActionCollectionViewCellDelegate?
    
    private var isLiked = false
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        button.setImage(image, for:.normal )
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "message", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        button.setImage(image, for:.normal )
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "paperplane", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
        button.setImage(image, for:.normal )
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(commentButton)
        
        //Actions
        
        likeButton.addTarget(self, action: #selector(didTapLike), for:  .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapComment), for:  .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for:  .touchUpInside)
    }
       
    
    
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    @objc func didTapLike(){
        if self.isLiked{
            let image = UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
            likeButton.setImage(image, for: .normal)
            likeButton.tintColor = .label
        }else{
            let image = UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
            likeButton.setImage(image, for: .normal)
            likeButton.tintColor = .systemRed
        }
        delegate?.postActionCollectionViewCellDidTapLiked(self, isLiked: !isLiked)
        self.isLiked = !isLiked
    }
    @objc func didTapComment(){
      
        delegate?.postActionCollectionViewCellDidTapComment(self)
        
    }
    @objc func didTapShare(){
        delegate?.postActionCollectionViewCellDidTapShare(self)
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size :CGFloat = contentView.height/1.15
        likeButton.frame = CGRect(x: 5, y: (contentView.height-size)/2, width:size , height: size)
        commentButton.frame = CGRect(x: likeButton.right+12, y: (contentView.height-size)/2, width: size,
        height: size)
        shareButton.frame = CGRect(x: commentButton.right+12, y: (contentView.height-size)/2, width: size, height: size)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: PostActionCollectionViewCellViewModel){
        self.isLiked = viewModel.isLiked
        
        if viewModel.isLiked{
            let image = UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))
            likeButton.setImage(image, for: .normal)
            likeButton.tintColor = .systemRed
        }
    }
                   
}

