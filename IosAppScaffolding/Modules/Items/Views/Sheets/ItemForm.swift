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
            Section(header: Text("Title")) {
                TextField("Title", text: $item.title)
            }
            Section(header: Text("Description")) {
                TextEditor(text: $item.description)
                    .frame(maxHeight: .infinity)
            }
            Section(header: Text("Image")) {
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
            Section(header: Text("Picture URL")) {
                Text(item.imageUrl ?? "")
                    .font(.caption)
            }
        }
    }
    
}



#Preview {
    ItemForm(item: .constant(Item.samples[0]))
}
