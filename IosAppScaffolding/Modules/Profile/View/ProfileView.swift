//
//  ProfileView.swift
//  IosAppScaffolding
//
//  Created by Christophe Guégan on 30/01/2025.
//

import SwiftUI

struct ProfileView: View {
        
    ///Main Body
    var body: some View {
        if let user = AuthService.shared.currentUser {
            
            List {
                Section{
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .frame(width: 72, height: 72)
                            .background(Color.secondary)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(user.fullName)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                Section("General") {
                    HStack {
                        SettingsRowView(
                            imageName: "gear",
                            title: "Version",
                            tintColor: Color.secondary
                        )
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Account") {
                    
                    Button {
                        try? AuthService.shared.signOut()
                    } label: {
                        SettingsRowView(
                            imageName: "arrow.left.circle.fill",
                            title: "Sign Out",
                            tintColor: Color.red
                        )
                    }
                    
                    Button {
                        print("Delete Account")
                    } label: {
                        SettingsRowView(
                            imageName: "xmark.circle.fill",
                            title: "Delete Account",
                            tintColor: Color.red
                        )
                    }
                    
                }
            }
            
        }
    }
}

#Preview {
    ProfileView()
}
