//
//  IosAppScaffoldingApp.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 30/01/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct IosAppScaffoldingApp: App {
    
    /// App Stores
    /// - Note: The stores are environment objects that will be passed to the views
    @State var store: ItemsStore
    
    /// App Initializer
    /// - Note:
    ///     - Configure Firebase
    ///     - Initialize the stores
    init() {
        FirebaseApp.configure()
        _store = State(initialValue: ItemsStore())
    }

    /// App Main Entry point
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}
