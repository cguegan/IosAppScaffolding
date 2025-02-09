//
//  User.swift
//  SwiftuiAuthBase
//
//  Created by Christophe Guégan on 10/07/2024.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    
    @DocumentID
    var id: String?
    var email: String
    var fullName: String
    var profilePicture: String?
    
    // Initials of the current user
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
    
}


// MARK: - Collection Name
// –––––––––––––––————————

extension User {
  static let collectionName = "users"
}


// MARK: - Samples
// –––––––––––––––

extension User {
    static var sample = User( email: "captain@silverware.com",
                              fullName: "John Doe",
                              profilePicture: "https://randomuser.me/api/portraits/men/1.jpg" )
}
