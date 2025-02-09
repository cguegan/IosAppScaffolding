//
//  ItemEditSheet.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 30/01/2025.
//

import SwiftUI

struct ItemEditSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(ItemsStore.self) private var store

    @Binding var item: Item
    
    var body: some View {
        NavigationStack {
            ItemForm(item: $item)
            .navigationBarTitle("Edit Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        store.update(self.item)
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
    ItemEditSheet(item: .constant(Item.samples[0]))
        .environment(ItemsStore())
}
