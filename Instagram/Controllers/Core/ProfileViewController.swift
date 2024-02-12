//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Elif İlay Eser
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let user: User
    private var isCurrentUser:Bool{
        return user.username.lowercased() == UserDefaults.standard.string(forKey: "username")?.lowercased() ?? ""
    }
    
    //MARK: - Init
    
    init(user:User){
        self.user=user
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder:NSCoder) {
        fatalError()
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = user.username.uppercased()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    
    func configure(){
        if isCurrentUser{
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target:self, action: #selector(didTapSetting))
        }
    }
    @objc func didTapSetting(){
        let vc = SettingsViewController()
        present(UINavigationController(rootViewController: vc),animated: true)
    }
}
