//
//  IpadTabView.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 09/02/2025.
//

import SwiftUI

struct IpadTabView: View {
    
    /// State prperties
    @State var visibility: NavigationSplitViewVisibility = .all
    @State var selection: Tab?
    
    enum Tab: Hashable {
        case items
        case profile
    }
    
    /// Main view
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(selection: $selection) {
                Label("Items", systemImage: "list.bullet")
                    .tag(Tab.items)
                Label("Profile", systemImage: "person.circle")
                    .tag(Tab.profile)
            }
            .listStyle(.sidebar)
            .navigationTitle("Sidebar")
        } detail: {
            switch selection {
            case .items: ItemsListView()
            case .profile: ProfileView()
            default: SplashScreen()
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}


// MARK: - Preview
// ———————————————

#Preview {
    IpadTabView()
        .environment(ItemsStore())
}
