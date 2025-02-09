//
//  ItemDetailView.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 30/01/2025.
//

import SwiftUI

struct ItemDetailView: View {
    
    @Environment(ItemsStore.self) private var store

    @Binding var item: Item
    
    @State private var showingEditView = false
    
    var imageUrl: URL? {
        guard let url = item.imageUrl else { return nil }
        guard let imageUrl = URL(string: url) else { return nil }
        return imageUrl
    }
    
    var body: some View {
        List {
            
            imageView
                
            Text(item.description)
                .font(.body)
                .padding(.bottom, 10)
                .listRowSeparator(.hidden)
                       
            Section(header: Text("Details")) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("**Created:** \(item.createdAt.timeAgoDisplay())")
                        .font(.caption)
                    Text("**Updated:** \(item.updatedAt.timeAgoDisplay())")
                        .font(.caption)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    showingEditView.toggle()
//                }) {
//                    Text("Edit")
//                }
                NavigationLink(destination: ItemEditView(item: $item)) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $showingEditView) {
            ItemEditSheet(item: $item)
        }
        .navigationBarTitle(item.title)
        .listStyle(.plain)
    }
}

extension ItemDetailView {
    
    @ViewBuilder
    var imageView: some View {
        if let imageUrl = imageUrl {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
                    .frame(height: 200, alignment: .center)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        } else {
//            Image(systemName: "photo")
//                .resizable()
//                .scaledToFit()
//                .frame(height: 24, alignment: .center)
//                .frame(maxWidth: .infinity, alignment: .center)
//                .foregroundColor(.secondary)
            EmptyView()
        }
    }
    
}


// MARK: - Preview
// ———————————————

#Preview {
    NavigationStack {
        ItemDetailView(item: .constant(Item.samples[0]))
            .environment(ItemsStore())
    }
}
