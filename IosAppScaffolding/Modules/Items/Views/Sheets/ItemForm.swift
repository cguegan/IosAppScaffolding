//
//  ItemForm.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 09/02/2025.
//

import SwiftUI

struct ItemForm: View {
    
    @Binding var item: Item
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $item.title)
            }
            
            Section(header: Text("Description")) {
                TextEditor(text: $item.description)
            }
        }
    }
}

#Preview {
    ItemForm(item: .constant(Item.samples[0]))
}
