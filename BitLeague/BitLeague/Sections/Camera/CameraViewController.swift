//
//  File.swift
//  BitLeague
//
//  Created by Ozzie Kirkby on 2019-02-01.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit
import Hero
import AVFoundation

class CameraViewController: UIViewController {
    // MARK: - Properties
    var bitmojiURL: String
    
    // MARK: - Views
    private let captureButton = CaptureButtonView()
    private var previewLayer = AVCaptureVideoPreviewLayer()
    private var capturedImage = UIImageView()
    private let bitmojiPreviewContainer = UIView()
    private let bitmojiPreviewImage = UIImageView()
    
    // MARK: - AVFoundation
    private let session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    
    init(bitmojiURL: String) {
        self.bitmojiURL = bitmojiURL
        super.init(nibName: nil, bundle: nil)
        hero.isEnabled = true
        
        captureButton.tapSelector = captureAction
        view.addSubviewForAutoLayout(captureButton)
        NSLayoutConstraint.activate([
            captureButton.widthAnchor.constraint(equalToConstant: 60),
            captureButton.heightAnchor.constraint(equalToConstant: 60),
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
        
        capturedImage.hero.id = "CapturedImage"
        view.addSubviewForAutoLayout(capturedImage)
        capturedImage.constrainToFill(view)
        
        addBitmojiPreview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        fetchBitmoji()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        session.startRunning()
        capturedImage.image = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        session.stopRunning()
    }
    
    // MARK: - View Setup
    func addBitmojiPreview() {
        bitmojiPreviewContainer.hero.modifiers = [.scale(0.5)]
        bitmojiPreviewContainer.layer.cornerRadius = 8
        bitmojiPreviewContainer.clipsToBounds = true
        bitmojiPreviewContainer.backgroundColor = UIColor.white
        view.addSubviewForAutoLayout(bitmojiPreviewContainer)
        NSLayoutConstraint.activate([
            bitmojiPreviewContainer.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            bitmojiPreviewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            bitmojiPreviewContainer.widthAnchor.constraint(equalToConstant: 125),
            bitmojiPreviewContainer.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        bitmojiPreviewImage.contentMode = .scaleAspectFit
        bitmojiPreviewContainer.addSubviewForAutoLayout(bitmojiPreviewImage)
        bitmojiPreviewImage.constrainToFill(bitmojiPreviewContainer, inset: UIEdgeInsets(equalInset: 8))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(returnToSelector))
        bitmojiPreviewContainer.addGestureRecognizer(tapGesture)
    }
    
    func fetchBitmoji() {
        bitmojiPreviewImage.image = nil
        DispatchQueue.global(qos: .background).async {
            let image = UIImage.load(from: self.bitmojiURL)
            DispatchQueue.main.async {
                self.bitmojiPreviewImage.image = image
            }
        }
    }
    
    // MARK: - Camera Setup
    private func checkAvailbility() {
        func failure() {
            present(UIAlertController(
                message: "You have camera permissions disabled for this app.",
                completionHandler: { _ in
                    self.dismiss(animated: true, completion: nil)
                }
            ), animated: true, completion: nil)
        }
        
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authorizationStatus {
        case .notDetermined:
            // permission dialog not yet presented, request authorization
            AVCaptureDevice.requestAccess(for: .video) { granted in
                guard granted == false else { return }
                failure()
            }
        case .authorized:
            return
        case .denied, .restricted:
            failure()
        }
    }
    
    private func setupCamera() {
        checkAvailbility()
        
        let availableDevices = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front
        )
            
        guard let camera = availableDevices.devices.first(where: { $0.position == .front }) else {
            present(UIAlertController(message: "Unable to proceed with Moji creation since no camera is available."), animated: true, completion: nil)
            return
        }
        
        do {
            let possibleCameraInput = try AVCaptureDeviceInput(device: camera)
            session.addInput(possibleCameraInput)
            
            if session.canAddOutput(photoOutput) {
                session.addOutput(photoOutput)
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.frame = view.bounds
            view.layer.addSublayer(previewLayer)
        } catch let error {
            present(UIAlertController(message: error.localizedDescription), animated: true, completion: nil)
        }
    }
    
    func captureAction() {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: 160,
            kCVPixelBufferHeightKey as String: 160
        ]
        settings.previewPhotoFormat = previewFormat
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    @objc func returnToSelector() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard
            let orientation = photo.metadata[String(kCGImagePropertyOrientation)] as? UInt32,
            let imageOrientation = UIImage.Orientation.orientation(fromCGOrientationRaw: orientation),
            let cgImage = photo.cgImageRepresentation()?.takeUnretainedValue()
        else { return }
        
        let image = UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation)
        
        capturedImage.hero.id = "CaptureImage"
        capturedImage.image = image
        
        let creator = CreatorViewController(bitmojiURL: bitmojiURL)
        creator.reactionImage.image = image
        present(creator, animated: true, completion: nil)
    }
}
