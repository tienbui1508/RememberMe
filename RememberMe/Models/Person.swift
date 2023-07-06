//
//  Person.swift
//  RememberMe
//
//  Created by Tien Bui on 5/7/2023.
//

import Foundation
import SwiftUI

struct Person: Identifiable, Codable, Comparable {
    var id: UUID
    var firstName: String = "Unkown"
    var lastName: String = "Unkown"
    var fullName: String {
        firstName + " " + lastName
    }
    var description: String?
    
    var photoURL: URL {
        FileManager.documentsDirectory.appendingPathComponent("\(id).jpg")
    }
    
    static let example = Person(id: UUID(), firstName: "Luffy", lastName: "Monkey D.", description: "Monkey D. Luffy, also known as \"Straw Hat Luffy\" and commonly as \"Straw Hat\", is the founder and captain of the increasingly infamous and powerful Straw Hat Pirates, as well as the most powerful of its top fighters. He desires to find the legendary treasure left behind by the late Gol D. Roger and thereby become the Pirate King, which would help facilitate an unknown dream of his that he has told only to Shanks, his brothers, and crew. He believes that being the Pirate King means having the most freedom in the world.")
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        if lhs.lastName == rhs.lastName {
            return lhs.firstName.lowercased() < rhs.firstName.lowercased()
        }
        return lhs.lastName.lowercased() < rhs.lastName.lowercased()
    }

}

