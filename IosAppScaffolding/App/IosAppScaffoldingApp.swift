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
    
    @State private var store: ItemsStore
    

    
    init() {
        FirebaseApp.configure()
        _store = State(initialValue: ItemsStore())
    }
        
    /// Environment Objects for the App
    

    /// App Main Entry point
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
        }
    }
}
