//
//  PeopleModel.swift
//  RememberMe
//
//  Created by Tien Bui on 5/7/2023.
//

import Foundation

class PeopleModel: ObservableObject {
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")
    
    @Published private(set) var people: [Person]
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            people = []
        }
        
        people = people.sorted()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    
    func createNewPerson(_ firstName: String, _ lastName: String, _ description: String) -> Person {
        let id = UUID()
        let newPerson = Person(id: id, firstName: firstName, lastName: lastName, description: description)
        people.append(newPerson)
        people = people.sorted()
        save()
        return newPerson
    }
    
    
    
    func deletePeople(at offsets: IndexSet) {
        // delete photo
        for offset in offsets {
            let person = people[offset]
            do {
                try FileManager().removeItem(at: person.photoURL)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        //delete person
        people.remove(atOffsets: offsets)
        
        save()
    }
   
    static let example = [
        Person(id: UUID(), firstName: "Luffy", lastName: "Monkey D.", description: "Monkey D. Luffy, also known as \"Straw Hat Luffy\" and commonly as \"Straw Hat\", is the founder and captain of the increasingly infamous and powerful Straw Hat Pirates, as well as the most powerful of its top fighters. He desires to find the legendary treasure left behind by the late Gol D. Roger and thereby become the Pirate King, which would help facilitate an unknown dream of his that he has told only to Shanks, his brothers, and crew. He believes that being the Pirate King means having the most freedom in the world."),
        Person(id: UUID(), firstName: "Shanks", description: "\"Red-Haired\" Shanks, commonly known as just \"Red Hair\", is the chief of the Red Hair Pirates and one of the Four Emperors that rule over the New World.")
    ]
}
