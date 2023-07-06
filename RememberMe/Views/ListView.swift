//
//  ListView.swift
//  RememberMe
//
//  Created by Tien Bui on 5/7/2023.
//

import SwiftUI

struct ListView: View {
    var person: Person
    private var image: Image? {
        guard let uiImage = try? UIImage(data: Data(contentsOf: person.photoURL)) else {
            return Image("Luffy")
        }
        return Image(uiImage: uiImage)
    }
    
    var body: some View {
        HStack {
            image?
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Rectangle())
            VStack(alignment: .leading) {
                Text(person.fullName)
                    .font(.title)
                Text(person.description ?? "")
                    .font(.caption)
                    .lineLimit(3)
            }
        }
        .padding(0)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(person: Person.example)
    }
}
