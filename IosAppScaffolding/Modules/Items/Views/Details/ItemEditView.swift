//
//  ItemEditView.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 10/02/2025.
//

import SwiftUI

struct ItemEditView: View {
    
    /// Environment properties
    @Environment(\.dismiss) var dismiss
    @Environment(ItemsStore.self) private var store

    /// Bindable properties
    @Binding var item: Item
    
    /// Main Body
    var body: some View {
        NavigationStack {
            ItemForm(item: $item)
            .navigationBarTitle("Edit Item")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Save") {
//                        store.update(self.item)
//                        dismiss()
//                    }
//                }
//            }
        }

    }
}

#Preview {
    ItemEditView(item: .constant(Item.samples[0]))
        .environment(ItemsStore())

}
