//
//  ImageSaver.swift
//  RememberMe
//
//  Created by Tien Bui on 5/7/2023.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    func writeToAppDirectory(image: UIImage, url: URL) {
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: url, options: [.atomic, .completeFileProtection])
            
        }
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?((error))
        } else {
            successHandler?()
        }
    }
}
