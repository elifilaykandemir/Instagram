//
//  ViewController.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 24.11.2022.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource{
    
    private var collectionView: UICollectionView?
    private var viewModels = [[HomeFeedCellTypes]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Instagram"
        view.backgroundColor = .systemBackground
        configureCollectionView()
        fetchPosts()
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func fetchPosts(){
        //mock data
        
        let postData : [HomeFeedCellTypes] = [
            .poster(
                viewModel: PosterCollectionViewCellViewModel(
                username: "iosacademy",
                profilePictureURL: URL(string: "https://iosacademy.io/assets/images/brand/icon.jpg")!
            )
        ),
            .post(
                viewModel: PostCollectionViewCellViewModel(
                    postURL:URL(string: "https://iosacademy.io/assets/images/brand/icon.jpg")!
                )
            ),
            .actions(viewModel: PostActionCollectionViewCellViewModel(isLiked: true)),
            .likeCount(viewModel:   PostLikesCollectionViewCellViewModel(likers:  ["kanyewest"])),
            .caption(viewModel: PostCaptionCollectionViewCellViewModel(username: "iosacademy",
                                                                       caption: "This is an awesome first post")),
            .timestamp(viewModel: PostDatetimeCollectionViewCellViewModel(date: Date()))
        ]
        viewModels.append(postData)
        collectionView?.reloadData()
    }
   
    
    //CollectionView
    let colors : [UIColor] = [.red,.orange,.blue,.green,.black,.gray]
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = viewModels[indexPath.section][indexPath.row]
        switch cellType{
        
        case .poster(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PosterCollectionViewCell.identifier,
                for: indexPath
            ) as? PosterCollectionViewCell else {
                fatalError()
                
            }
            cell.configure(with: viewModel)
            return cell
        case .post(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCollectionViewCell.identifier,
                for: indexPath
            )as? PostCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            cell.contentView.backgroundColor = colors[indexPath.row]
            return cell
        case .actions(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostActionCollectionViewCell.identifier,
                for: indexPath
            )as? PostActionCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            cell.contentView.backgroundColor = colors[indexPath.row]
            return cell
        case .likeCount(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostLikesCollectionViewCell.identifier,
                for: indexPath
            )as? PostLikesCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            cell.contentView.backgroundColor = colors[indexPath.row]
            return cell
        case .caption(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostCaptionCollectionViewCell.identifier,
                for: indexPath
            ) as? PostCaptionCollectionViewCell else {
                fatalError()
                
            }
            cell.configure(with: viewModel)
            cell.contentView.backgroundColor = colors[indexPath.row]
            return cell
        case .timestamp(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostDatetimeCollectionViewCell.identifier,
                for: indexPath
            ) as? PostDatetimeCollectionViewCell else {
                fatalError()
                
            }
            cell.configure(with: viewModel)
            cell.contentView.backgroundColor = colors[indexPath.row]
            return cell
        }
        
    }

    
}

extension HomeViewController {
    func configureCollectionView(){
        let sectionHeight: CGFloat = 240 + view.width
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: {index,_ -> NSCollectionLayoutSection? in
        // Item
            
            let posterItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:.absolute(60)
                )
            )
            
        // Cell for poster
            let postItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:.fractionalWidth(1)
                )
            )
            

        //Action cell
            
            let actionItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:.absolute(40)
                )
            )
        
        //Like Count Cell
            let likeCountItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:.absolute(40)
                )
            )
        //Caption Cell
            let captionItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:.absolute(60)
                )
            )

        //Timestamp Cell
            let timestampItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension:.absolute(40)
                )
            )

        //Group
                                              
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(sectionHeight)),
                subitems: [posterItem,
                           postItem,
                           actionItem,
                           likeCountItem,
                           captionItem,
                           timestampItem]
        
            )
          
            
        //Section
        let section = NSCollectionLayoutSection(group: group)
        
            section.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0)
            
        return section
        
        
        })
        )
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        collectionView.register(PostActionCollectionViewCell.self, forCellWithReuseIdentifier: PostActionCollectionViewCell.identifier)
        collectionView.register(PostLikesCollectionViewCell.self, forCellWithReuseIdentifier: PostLikesCollectionViewCell.identifier)
        collectionView.register(PostCaptionCollectionViewCell.self, forCellWithReuseIdentifier: PostCaptionCollectionViewCell.identifier)
        collectionView.register(PostDatetimeCollectionViewCell.self, forCellWithReuseIdentifier: PostDatetimeCollectionViewCell.identifier)
        self.collectionView = collectionView
        
    }
}
