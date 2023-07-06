//
//  AddPersonView.swift
//  RememberMe
//
//  Created by Tien Bui on 5/7/2023.
//

import SwiftUI
import CoreImage

struct AddPersonView: View {
    @ObservedObject var data: PeopleModel
    @Environment(\.dismiss) var dissmiss
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingNewPersonDetails = false
    @State private var inputImage: UIImage?
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var description: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.secondary)
                
                Text("Tap to select a picture")
                    .foregroundColor(.white)
                    .font(.headline)
                
                image?
                    .resizable()
                    .scaledToFit()
            }
            .onTapGesture {
                showingImagePicker = true
            }
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            
            VStack {
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Description", text: $description)
                
                Spacer()
                
                Button {
                    let id = UUID()
                    let newPerson = Person(id: id, firstName: firstName, lastName: lastName, description: description)
                    let photoURL = newPerson.photoURL
                    savePhoto(photoURL: photoURL)
                    data.addNewPerson(newPerson)
                    data.save()
                    dissmiss()
                } label: {
                    Text("Save")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(.primary)
                        .clipShape(Capsule())
                }
                .disabled(image == nil && (firstName.isEmpty || lastName.isEmpty))
            }
            .padding()
        }
    }
    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func savePhoto(photoURL: URL) {
        guard let inputImage = inputImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToAppDirectory(image: inputImage, url: photoURL)
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(data: PeopleModel())
    }
}
