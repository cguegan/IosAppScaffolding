//
//  StorageManager.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 09/02/2025.
//

import Foundation
import FirebaseStorage
import SwiftUI


public class StorageManager: ObservableObject {
    
    let storage = Storage.storage()
    
    func upload(image: UIImage, fileName: String) {
        let storageRef = storage.reference().child("images/myImage.jpg")
        let resizedImage = image.aspectFittedToHeight(512)
        let data = resizedImage.jpegData(compressionQuality: 0.5)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error uploading: \(error)")
                    return
                }
                print("Upload successful")
                
            }
        }
            
    }
        

    
}
