//
//  ItemForm.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 09/02/2025.
//

import SwiftUI
import PhotosUI


struct ItemForm: View {
    
    /// Environment Properpties
    @Environment(ItemsStore.self) private var store

    /// Bindings Properpties
    @Binding var item: Item
    
    /// State Properpties
    @State private var selectedImage: PhotosPickerItem?
    @State private var imageData: Data?

    /// Main View
    var body: some View {
        Form {
            
            /// Title Section
            Section(header: Text("Title")) {
                TextField("Title", text: $item.title)
            }
            
            /// Description Section
            Section(header: Text("Description")) {
                TextEditor(text: $item.description)
                    .frame(maxHeight: .infinity)
            }
            
            /// Image Section
            Section(header: Text("Image")) {
                
                /// Image Picker from library
                HStack(spacing: 12) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .imageScale(.small)
                        .font(.title)
                        .foregroundStyle(Color.accentColor)
                        .frame(width: 24)
                    
                    PhotosPicker( selection: $selectedImage,
                                  matching: .images) { Text("Pick Photo") }
                        .onChange(of: selectedImage) { _, selectedImage in
                            if let selectedImage = selectedImage {
                                store.uploadImage(selectedImage, for: item)
                            }
                        }
                }
                
                // TODO: - Take picture from camera
                /// Take picture from camera
                HStack(spacing: 12) {
                    Image(systemName: "camera")
                        .imageScale(.small)
                        .font(.title)
                        .foregroundStyle(Color.accentColor)
                        .frame(width: 24)
                    
                    PhotosPicker( selection: $selectedImage,
                                  matching: .images) { Text("Take Photo") }
                        .onChange(of: selectedImage) { _, selectedImage in
                            if let selectedImage = selectedImage {
                                store.uploadImage(selectedImage, for: item)
                            }
                        }
                }
                                
                /// Delete Image
                if let imageUrl = item.imageUrl {
                    HStack(spacing: 12) {
                        Image(systemName: "trash")
                            .imageScale(.small)
                            .font(.title)
                            .foregroundStyle(.red)
                            .frame(width: 24)
                        
                        Button( "Delete") {
                            store.deleteImage(imageUrl, for: item)
                        }
                        .foregroundStyle(.red)
                    }
                    
                    
                }
            }
            
            /// Picture URL Section (To be deleted)
            Section(header: Text("Picture URL")) {
                Text(item.imageUrl ?? "")
                    .font(.caption)
            }
        }
    }
    
}



#Preview {
    ItemForm(item: .constant(Item.samples[0]))
        .environment(ItemsStore())
}
