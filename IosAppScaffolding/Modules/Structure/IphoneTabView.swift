//
//  IphoneTabView.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 09/02/2025.
//

import SwiftUI

struct IphoneTabView: View {
    
    var body: some View {
        TabView {
            Tab("Items", systemImage: "list.bullet") {
                ItemsListView()
            }
            Tab("profile", systemImage: "person") {
                ProfileView()
            }
        }
        
    }
}

#Preview {
    IphoneTabView()
}
