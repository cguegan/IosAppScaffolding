//
//  ItemsStore.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 30/01/2025.
//

import Foundation
import Observation
import FirebaseFirestore
import FirebaseStorage
import SwiftUI
import PhotosUI


@Observable
final class ItemsStore {

    var items: [Item] = []
    var error: Error?
    var errorMessage: String?
    
    /// Firestore database reference
    ///
    let db = Firestore.firestore()
    let collectionName = "items"
    var listener: ListenerRegistration?
    
    /// Storage of images
    ///
    let storage = Storage.storage()
    let storageRef = Storage.storage().reference()
    
    /// Initialize the store and enable live sync
    ///
    init() {
        enableLiveSync()
    }
    
    /// Deinitialize the store and remove the listener
    ///
    deinit {
        listener?.remove()
    }
    
    /// Enable live sync with Firestore
    /// - Note: This method will listen to Firestore changes and update of the items
    ///         array for the current user only.
    ///
    func enableLiveSync() {
        
        print("DEBUG: Enabling document live sync ...")
        print("DEBUG: Current user ID: \(AuthService.shared.userSession?.uid ?? "No User ID")")
        
        listener = db.collection(collectionName)
            .whereField("user_id", isEqualTo: AuthService.shared.userSession?.uid ?? "")
            .addSnapshotListener { querySnapshot, error in
                if let querySnapshot = querySnapshot {
                    self.items = querySnapshot.documents.compactMap { document in
                        return try? document.data(as: Item.self)
                    }
                }
            }
    }
    
    
    // MARK: - CRUD Operations
    
    /// Add a new document to Firestore database
    /// - Parameter document: The document to add
    /// - Returns: Void
    /// - Note: This method is asynchronous
    ///
    func add(_ item: Item) {
        do {
            try db.collection(collectionName).addDocument(from: item)
        } catch {
            print("DEBUG: Failed to add document with error: \(error.localizedDescription)")
            self.error = error
            self.errorMessage = error.localizedDescription
        }
    }
    
    /// Delete a document from Firestore
    /// - Parameter document: The document to delete
    /// - Returns: Void
    ///
    func remove(_ item: Item) {
        
        /// Check if document has an ID
        guard let id = item.id else { return }
        
        db.collection(collectionName).document(id).delete()
        
    }
    
    /// Update a document in Firestore
    /// - Parameter document: The document to update
    /// - Returns: Void
    ///
    func update(_ item: Item) {
        
        /// Check if document has an ID
        guard let id = item.id else { return }
        
        /// Set updated date
        /// - Note: This is important to keep track of the last update date
        var item = item
        item.updatedAt = Date()
        
        /// Update the document
        do {
            try db.collection(collectionName).document(id).setData(from: item)
        } catch {
            print("DEBUG: Failed to update document with error: \(error.localizedDescription)")
            self.error = error
            self.errorMessage = error.localizedDescription
        }
        
    }
    
    
    // MARK: - Upload Image to Firebase Storage
    
    /// Upload a photos picker item to Firebase Storage
    /// - Parameters:
    ///     - image: The image to upload as PhotosPickerItem
    ///     - item: The item to associate the image with
    ///
    func uploadImage(_ image: PhotosPickerItem, for item: Item) {
        /// Load the image data
        image.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let imageData):
                if let imageData = imageData,
                   let uiImage = UIImage(data: imageData) {
                    self.uploadImage(uiImage, for: item)
                } else {
                    print("[ ERROR ] No supported content type found.")
                }
            case .failure(let error):
                print("[ ERROR ] While loading transferable: \(error.localizedDescription)")
            }
        }
    }
    
    /// Upload an image to Firebase Storage
    /// - Parameters:
    ///     - image: The image to upload in UIImage format
    ///     - item: The item to associate the image with
    ///
    func uploadImage(_ image: UIImage, for item: Item) {
        
        /// Create a reference to the image in Firebase Storage
        let storagePath = storageRef.child("images/\(item.id ?? UUID().uuidString).jpg")
        let resizedImage = image.aspectFittedToHeight(512)
        let data = resizedImage.jpegData(compressionQuality: 0.5)
        
        /// Set the metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        /// Upload the image
        if let data = data {
            storagePath.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("[ Error ] While uploading: \(error)")
                } else {
                    storagePath.downloadURL { (url, error) in
                        if let url = url {
                            var item = item
                            item.imageUrl = url.absoluteString
                            self.update(item)
                        }
                    }
                }
            }
        }
    }
    
    /// Delete an image from Firebase Storage
    /// - Parameters:
    ///    - imageUrl: The URL of the image to delete
    ///    - item: The item to associate the image with
    ///
    func deleteImage(_ imageUrl: String, for item: Item) {
        
        /// Create a reference to the image in Firebase Storage
        let storagePath = storage.reference(forURL: imageUrl)
        
        /// Delete the image
        storagePath.delete { error in
            if let error = error {
                print("[ Error ] While deleting: \(error)")
            } else {
                var item = item
                item.imageUrl = nil
                self.update(item)
            }
        }
    }
    
    

    
}
