//
//  Item.swift
//  SwiftuiAuthBase
//
//  Created by Christophe Guégan on 12/07/2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct Item: Identifiable, Codable {
    
    @DocumentID
    var id: String?
    var userID: String?
    var title: String
    var description: String
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    
    // Init
    init(id: String? = nil, title: String, description: String = "") {
        self.id = id
        self.userID = Auth.auth().currentUser?.uid ?? ""
        self.title = title
        self.description = description
    }
    
    // Coding
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case userID = "user_id"
        case description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

// MARK: - Samples
// –––––––––––––––

extension Item {
    static var samples: [Item] = [
        Item(id: "1", title: "Item 1", description: LoremIpsum.short),
        Item(id: "2", title: "Item 2", description: LoremIpsum.short),
        Item(id: "3", title: "Item 3", description: LoremIpsum.short),
        Item(id: "4", title: "Item 4", description: LoremIpsum.short),
        Item(id: "5", title: "Item 5", description: LoremIpsum.short),
        Item(id: "6", title: "Item 6", description: LoremIpsum.short),
        Item(id: "7", title: "Item 7", description: LoremIpsum.short),
        Item(id: "8", title: "Item 8", description: LoremIpsum.short),
        Item(id: "9", title: "Item 9", description: LoremIpsum.short),
    ]
}
