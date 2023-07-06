//
//  ContentView.swift
//  RememberMe
//
//  Created by Tien Bui on 5/7/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = PeopleModel()
    @State private var addingNewPerson = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data.people.sorted()) { person in
                    NavigationLink {
                        DetailsView(person: person)
                    } label: {
                        ListView(person: person)
                    }
                    
                }
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .navigationTitle("Remember Me")
            .toolbar {
                EditButton()
                Button {
                    addingNewPerson.toggle()
                } label: {
                    Label("Adding new person", systemImage: "plus")
                }
            }
            .sheet(isPresented: $addingNewPerson) {
                AddPersonView(data: data)
            }
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        data.people.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
