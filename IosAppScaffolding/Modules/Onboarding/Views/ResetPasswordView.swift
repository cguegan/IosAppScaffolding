//
//  ForgotPasswordView.swift
//  SwiftuiAuthBase
//
//  Created by Christophe Guégan on 12/07/2024.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @Bindable var service: LoginManager
    
    var body: some View {
        VStack {
            
            // Title
            Text("Reset your password")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.bottom, 40)
            
            // Email
            ImputView( text: $service.resetPasswordEmail,
                       title: "please enter you email Address",
                       placeholder: "name@example.com"
            )
            .autocapitalization(.none)
            
            Text("We will send you an email with a link to reset your password.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.vertical, 40)
                
            
            // Reset Button
            Button {
                service.resetPassword()
            } label: {
                HStack {
                    Text("Reset your password")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame( width: UIScreen.main.bounds.width - 32,
                        height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!service.isValidEmail)
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()

        }
        .padding()
    }
}

#Preview {
    ResetPasswordView(service: LoginManager())
}
