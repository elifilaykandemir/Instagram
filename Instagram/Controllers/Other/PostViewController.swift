//
//  PostViewController.swift
//  Instagram
//
//  Created by Elif İlay Eser
//

import UIKit

class PostViewController: UIViewController {
    
    let post: Post
    
    init(post: Post){
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post"
        view.backgroundColor = .systemBackground
    }
    

  
}
