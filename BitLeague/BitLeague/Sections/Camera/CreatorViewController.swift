//
//  CreatorViewController.swift
//  BitLeague
//
//  Created by Ozzie Kirkby on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit
import Hero
import FirebaseStorage
import FirebaseFirestore

class CreatorViewController: UIViewController {
    
    let postButton = UIButton()
    let loadingIndicator = UIActivityIndicatorView()
    let reactionImage = PanCropImage()
    let bitmojiURL: String
    
    init(bitmojiURL: String, bitmoji: UIImage) {
        self.bitmojiURL = bitmojiURL
        super.init(nibName: nil, bundle: nil)
        hero.isEnabled = true
        
        view.backgroundColor = UIColor.white
        
        reactionImage.layer.cornerRadius = 12
        reactionImage.clipsToBounds = true
        reactionImage.hero.id = "CaptureImage"
        view.addSubviewForAutoLayout(reactionImage)
        NSLayoutConstraint.activate([
            reactionImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            reactionImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            reactionImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            reactionImage.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        let bitmojiPreviewView = UIImageView()
        bitmojiPreviewView.contentMode = .scaleAspectFit
        bitmojiPreviewView.hero.id = "BitmojiContainer"
        bitmojiPreviewView.image = bitmoji
        view.addSubviewForAutoLayout(bitmojiPreviewView)
        NSLayoutConstraint.activate([
            bitmojiPreviewView.rightAnchor.constraint(equalTo: reactionImage.rightAnchor, constant: -8),
            bitmojiPreviewView.topAnchor.constraint(equalTo: reactionImage.topAnchor, constant: 8),
            bitmojiPreviewView.widthAnchor.constraint(equalToConstant: 50),
            bitmojiPreviewView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let moveStack = UIStackView(distribution: .fill, axis: .horizontal, spacing: 8)
        view.addSubviewForAutoLayout(moveStack)
        NSLayoutConstraint.activate([
            moveStack.topAnchor.constraint(equalTo: reactionImage.bottomAnchor, constant: 16),
            moveStack.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 16),
            moveStack.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -16)
        ])
        
        let moveIcon = UIImageView()
        moveIcon.contentMode = .center
        moveIcon.image = UIImage(named: "dragIcon")
        moveIcon.setContentHuggingPriority(.required, for: .horizontal)
        moveStack.addArrangedSubview(moveIcon)
        
        let moveIndicatorLabel = UILabel()
        moveIndicatorLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        moveIndicatorLabel.textColor = UIColor(hexString: "hex")
        moveIndicatorLabel.textAlignment = .center
        moveIndicatorLabel.numberOfLines = 0
        moveIndicatorLabel.text = "Drag to make your photo fit"
        moveStack.addArrangedSubview(moveIndicatorLabel)
        
        let actionStack = UIStackView(distribution: .fillEqually, axis: .horizontal, spacing: 8)
        actionStack.alignment = .center
        view.addSubviewForAutoLayout(actionStack)
        NSLayoutConstraint.activate([
            actionStack.topAnchor.constraint(equalTo: moveStack.bottomAnchor, constant: 32),
            actionStack.widthAnchor.constraint(equalToConstant: 136),
            actionStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let retryButton = UIButton()
        retryButton.setContentHuggingPriority(.required, for: .horizontal)
        retryButton.setImage(UIImage(named: "retryIcon"), for: .normal)
        retryButton.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
        actionStack.addArrangedSubview(retryButton)
        
        let saveButton = UIButton()
        saveButton.setImage(UIImage(named: "saveIcon"), for: .normal)
        actionStack.addArrangedSubview(saveButton)
        
        postButton.setImage(UIImage(named: "postButton"), for: .normal)
        postButton.addTarget(self, action: #selector(postAction), for: .touchUpInside)
        view.addSubviewForAutoLayout(postButton)
        postButton.constrainToFillHorizontally(view, againstLayoutMargins: true)
        NSLayoutConstraint.activate([
            postButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        loadingIndicator.hidesWhenStopped = true
        view.addSubviewForAutoLayout(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 30),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func retryAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func postAction() {
        guard let cropped = croppedImage(), let data = cropped.jpegData(compressionQuality: 0.9) else { return }
        
        guard let user = Device.user(),
            let userID = user.externalId,
            let avatarURL = user.avatar,
            let displayName = user.displayName
        else { return }
        postButton.isHidden = true
        loadingIndicator.startAnimating()
        
        let storage = Storage.storage().reference()
        let db = FireClient.shared.db
        
        let reactionRef = storage.child("reactions/\(UUID().uuidString)")
        reactionRef.putData(data, metadata: nil) { (metadata, error) in
            guard error == nil else {
                self.handlePosting(error: error!)
                return
            }
            reactionRef.downloadURL { url, error in
                guard let url = url, error == nil else {
                    if let error = error {
                        self.handlePosting(error: error)
                    }
                    return
                }
                
                let postId = UUID().uuidString
                
                db.collection("posts").document(postId).setData([
                    "bitmoji": [
                        "image": self.bitmojiURL,
                        "recreations": 0
                    ],
                    "claps": 0,
                    "date": Date(),
                    "image": url.absoluteString,
                    "user": [
                        "avatar": avatarURL,
                        "displayName": displayName,
                        "id": userID
                    ]
                ])
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func handlePosting(error: Error) {
        postButton.isHidden = false
        loadingIndicator.stopAnimating()
        present(UIAlertController(message: error.localizedDescription), animated: true)
    }
    
    func croppedImage() -> UIImage? {
        guard let image = reactionImage.image?.fixedOrientation() else { return nil }
        guard let cgimage = image.cgImage else { return nil }
        let container = reactionImage.bounds
        
        let ratio = image.size.width / container.width
        let posX: CGFloat = 0.0
        // Okay so why this logic... Well so first you need to move the position to the center of the image,
        // now you need to move the "crop offset" defined by the user and finally you need to translate
        // even more down since the crop bounds offset is technically measured from the center.
        let posY: CGFloat = (image.size.height / 2) - (reactionImage.offset() * ratio) - ((container.height * ratio) / 2)
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: image.size.width, height: container.height * ratio)
        
        // Create bitmap image from context using the rect
        guard let imageRef = cgimage.cropping(to: rect) else { return nil }
        return UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
    }
}
