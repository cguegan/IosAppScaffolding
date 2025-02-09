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
    
    var body: some View {
        List {
            Text(item.description)
                .font(.body)
                .padding(.bottom, 10)
                .listRowSeparator(.hidden)
                       
            Section(header: Text("Details")) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("**Created:** \(item.createdAt.timeAgoDisplay())")
                    Text("**Updated:** \(item.updatedAt.timeAgoDisplay())")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingEditView.toggle()
                }) {
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


// MARK: - Preview
// ———————————————

#Preview {
    NavigationStack {
        ItemDetailView(item: .constant(Item.samples[0]))
    }
}
