//
//  ContentView.swift
//  RememberMe
//
//  Created by Tien Bui on 5/7/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data = PeopleModel()
    @State private var addingNewPerson = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data.people) { person in
                    NavigationLink {
                        DetailsView(person: person)
                    } label: {
                        ListView(person: person)
                    }
                    
                }
                .onDelete(perform: data.deletePeople)
                
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
