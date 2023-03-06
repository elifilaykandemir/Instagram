//
//  HomeFeedCellTypes.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 6.03.2023.
//

import Foundation

enum HomeFeedCellTypes {
    case poster(viewModel:PosterCollectionViewCellViewModel)
    case post(viewModel:PostCollectionVireCellViewModel)
    case actions(viewModel:PostActionCollectionViewCellViewModel)
    case likeCount(viewModel:PostLikesCollectionViewCellViewModel)
    case caption(viewModel:PostCaptionCollectionViewCellViewModel)
    case timestamp(viewModel:PostDatetimeCollectionViewCellViewModel)
}
