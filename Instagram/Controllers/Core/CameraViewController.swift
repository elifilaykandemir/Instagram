//
//  CameraViewController.swift
//  Instagram
//
//  Created by Elif İlay KANDEMİR on 2.02.2023.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpNavBar()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    @objc func didTapClose(){
        tabBarController?.selectedIndex = 0
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpNavBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose)
        )
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(),for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
}
