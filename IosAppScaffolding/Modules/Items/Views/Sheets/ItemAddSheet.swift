//
//  ItemAddSheet.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 30/01/2025.
//

import SwiftUI

struct ItemAddSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(ItemsStore.self) private var store

    @State var item: Item = Item(title: "")
    
    
    var body: some View {
        NavigationStack {
            ItemForm(item: $item)
            .navigationBarTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        store.add(self.item)
                        dismiss()
                    }
                }
            }
        }
    }
}


// MARK: - Preview
// ———————————————

#Preview {
    ItemAddSheet()
        .environment(ItemsStore())
}
