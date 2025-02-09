//
//  ItemListRow.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 31/01/2025.
//

import SwiftUI

struct ItemListRow: View {
    
    @Environment(ItemsStore.self) private var store
    
    var item: Item
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            
            Image(systemName: "photo")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                withAnimation {
                    store.remove(item)
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

// MARK: - Preview
// ———————————————

#Preview {
    ItemListRow(item: Item.samples[0])
        .environment(ItemsStore())
}
