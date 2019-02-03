//
//  BitmojiSelectorController.swift
//  BitLeague
//
//  Created by Ozzie Kirkby on 2019-02-02.
//  Copyright © 2019 kirkbyo. All rights reserved.
//

import UIKit
import SCSDKBitmojiKit
import Hero

class BitmojiSelectorViewController: UIViewController, SCSDKBitmojiStickerPickerViewControllerDelegate {
    init() {
        super.init(nibName: nil, bundle: nil)
        hero.isEnabled = true
        hero.modalAnimationType = .slide(direction: .right)
        
        view.backgroundColor = UIColor.white
        let stickerPickerVC = SCSDKBitmojiStickerPickerViewController()
        stickerPickerVC.delegate = self
        addChild(stickerPickerVC)
        if let stickerView = stickerPickerVC.view {
            view.addSubviewForAutoLayout(stickerView)
            NSLayoutConstraint.activate([
                stickerView.leftAnchor.constraint(equalTo: view.leftAnchor),
                stickerView.rightAnchor.constraint(equalTo: view.rightAnchor),
                stickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                stickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bitmojiStickerPickerViewController(_ stickerPickerViewController: SCSDKBitmojiStickerPickerViewController, didSelectBitmojiWithURL bitmojiURL: String, image: UIImage?) {
        navigationController?.pushViewController(CameraViewController(bitmojiURL: bitmojiURL), animated: true)
    }
}
