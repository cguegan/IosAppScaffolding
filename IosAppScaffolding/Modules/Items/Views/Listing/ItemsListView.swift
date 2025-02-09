//
//  ItemsListView.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 30/01/2025.
//

import SwiftUI

struct ItemsListView: View {
    
    /// Environment Properpties
    @Environment(ItemsStore.self) private var store

    /// State Properpties
    @State private var showingAddItemView = false

    /// Main Body
    var body: some View {
        @Bindable var store = store
        NavigationStack {
            List {
                ForEach($store.items) { $item in
                    NavigationLink(destination: ItemDetailView(item: $item)) {
                        ItemListRow(item: item)
                    }
                }
            }
            .navigationTitle("Items")
            .sheet(isPresented: $showingAddItemView) {
                ItemAddSheet()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddItemView.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }
}


// MARK: - Preview
// ———————————————

#Preview {
    ItemsListView()
}
