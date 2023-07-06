//
//  DetailsView.swift
//  RememberMe
//
//  Created by Tien Bui on 5/7/2023.
//

import SwiftUI

struct DetailsView: View {
    var person: Person
    private var image: Image {
        guard let uiImage = try? UIImage(data: Data(contentsOf: person.photoURL)) else {
            return Image("Luffy")
        }
        return Image(uiImage: uiImage)
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            Spacer()
            
            Group {
                Text(person.fullName)
                    .font(.largeTitle)
                Text(person.description ?? "")
            }
            .padding()
            .background()
            .backgroundStyle(.ultraThinMaterial)
            .padding(.bottom)
        }
        .background(image.resizable().scaledToFill())
        .ignoresSafeArea()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(person: Person.example)
    }
}
