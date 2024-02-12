//
//  CameraViewController.swift
//  Instagram
//
//  Created by Elif İlay Eser
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    private var cameraOutput = AVCapturePhotoOutput()
    private var captureSession: AVCaptureSession?
    private let previewLayer = AVCaptureVideoPreviewLayer()
    
    private let cameraView = UIView()
    
    private let shutterButton:UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.label.cgColor
        button.backgroundColor = nil
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        title = "Take Photo"
        view.addSubview(cameraView)
        view.addSubview(shutterButton)
        setUpNavBar()
        checkCameraPermission()
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
        if let session = captureSession,!session.isRunning{
            session.startRunning()
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession?.stopRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraView.frame = view.bounds
        previewLayer.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width:view.width , height: view.width)
        
        let buttonSize: CGFloat = view.width/5
        shutterButton.frame = CGRect(x:(view.width - buttonSize)/2 , y: view.safeAreaInsets.top + view.width + 100, width: buttonSize, height: buttonSize)
        shutterButton.layer.cornerRadius = buttonSize/2

    }
    
    private func checkCameraPermission(){
        
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else{
                    print("the user has not granted to access the camera")
                    self.handleDismiss()
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted, .denied:
            print("the user can't give camera access due to some restriction.")
            self.handleDismiss()
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
     
    }
    
    private func setUpCamera(){
        let captureSession = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video){
            do{
                let cameraInput = try AVCaptureDeviceInput(device:device)
                if captureSession.canAddInput(cameraInput){
                    captureSession.addInput(cameraInput)
                }
            }
            catch{
                print(error)
            }
            
            if captureSession.canAddOutput(cameraOutput){
                captureSession.addOutput(cameraOutput)
            }
            
            previewLayer.session = captureSession
            previewLayer.videoGravity = .resizeAspectFill
    
            cameraView.layer.addSublayer(previewLayer)
            
            DispatchQueue.global(qos: .userInitiated).async {
                captureSession.startRunning()
            }
        }
    }
    @objc func didTapClose(){
        tabBarController?.selectedIndex = 0
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func didTapTakePhoto(){
        cameraOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    
    private func setUpNavBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose)
        )
        
//        navigationController?.navigationBar.setBackgroundImage(UIImage(),for:.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.backgroundColor = .clear
    }
    
}

extension CameraViewController : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?){
        guard let data = photo.fileDataRepresentation(), let image = UIImage(data: data) else {
            return
        }
        captureSession?.stopRunning()
        
        let vc = PostEditViewController(image: image)
        if #available(iOS 14.0, *) {
            vc.navigationItem.backButtonDisplayMode = .minimal
        } else {
            vc.navigationItem.backButtonTitle = ""
        }
        navigationController?.pushViewController(vc, animated: false)
    }
}
