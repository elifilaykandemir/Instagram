//
//  HomeFeedCellTypes.swift
//  Instagram
//
//  Created by Elif İlay Eser
//

import Foundation

enum HomeFeedCellTypes {
    case poster(viewModel:PosterCollectionViewCellViewModel)
    case post(viewModel:PostCollectionViewCellViewModel)
    case actions(viewModel:PostActionCollectionViewCellViewModel)
    case likeCount(viewModel:PostLikesCollectionViewCellViewModel)
    case caption(viewModel:PostCaptionCollectionViewCellViewModel)
    case timestamp(viewModel:PostDatetimeCollectionViewCellViewModel)
}
