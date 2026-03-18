//
//  PictureModal.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 12/03/2026.
//

import SwiftUI

struct PictureModal: View {
    @Binding var entry: Entry

    @State private var showingImagePicker = false
    @State private var selectedImage: Image?
    @State private var inputImage: UIImage?
    func loadImage() {
        guard let inputImage else { return }
        selectedImage = Image(uiImage: inputImage)
    }
    
    @State private var isUploading = false

    @Binding var showingPicturePopover: Bool
    
    @Binding var entryImage: [Attachment]?
    
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()

            EntryOptionModal(
                image: "photo.circle.fill",
                option: "Photo"
            ) {
                Text("Une photo pour illustrer ta journée ?")
                    .italic()
                    .bold()
                    .opacity(0.5)
                    .padding(.bottom, 12)
                
                if isUploading {
                    ProgressView("Upload en cours...")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.green4)
                        .bold()
                        .opacity(0.7)
                    
                } else {
                    
                    Button {
                        showingImagePicker = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "plus.circle.fill")
                            Text("Choisir une photo")
                                .font(.system(size: 12))
                                .bold()
                        }
                        .opacity(0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    if let selectedImage {
                        selectedImage
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                        
                    } else if let url = entry.image?.first?.url {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .background(
                                    RoundedRectangle(cornerRadius: 12).stroke(
                                        .white.opacity(0.4),
                                        lineWidth: 2
                                    )
                                )
                        } placeholder: {
                        }
                    }
                }
            } optionAction: {
                guard let picture = inputImage else { return }
                
                Task {
                    do {
                        isUploading = true
                        let attachment = try await entry.uploadImageAsAttachment(picture)
                        
                        await MainActor.run {
                            entryImage = [attachment]
                            loadImage()
                            isUploading = false
                            showingPicturePopover = false
                        }

                    } catch {
                        print("Erreur upload image: \(error)")
                        
                        showingAlert = true
                        
                        await MainActor.run {
                            isUploading = false
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) {
            loadImage()
        }
        .alert("Une erreur s'est produite", isPresented: $showingAlert) {
            Button("Réessayer", role: .cancel) { }
        }
    }
}

#Preview {
    let sampleEntry = Entry(
//        id: 2,
        date: Date(),
        emotion: .happiness,
        notes: "",
        image: nil,
        anxiety: .neutral,
        energy: .neutral,
        appetite: .neutral,
        sleep: .sleep,
        user: [""]
    )
    PictureModal(entry: .constant(sampleEntry), showingPicturePopover: .constant(true), entryImage: .constant(sampleEntry.image))
}

