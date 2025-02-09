//
//  ItemsStore.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 30/01/2025.
//

import Foundation
import Observation
import FirebaseFirestore

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
    /// - Note: This method will listen to Firestore changes and update the items array
    func enableLiveSync() {
        
        print("DEBUG: Enabling document live sync ...")
        listener = db.collection(collectionName)
            .addSnapshotListener { querySnapshot, error in
                if let querySnapshot = querySnapshot {
                    self.items = querySnapshot.documents.compactMap { document in
                        return try? document.data(as: Item.self)
                    }
                }
            }
    }
    
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
        
        /// Update the document
        do {
            try db.collection(collectionName).document(id).setData(from: item)
        } catch {
            print("DEBUG: Failed to update document with error: \(error.localizedDescription)")
            self.error = error
            self.errorMessage = error.localizedDescription
        }
        
    }
    
}

