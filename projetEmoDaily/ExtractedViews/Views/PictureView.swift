//
//  PictureView.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 12/03/2026.
//

import SwiftUI

struct PictureView: View {
    var entry: Entry
    
    @State private var showingImagePicker = false
    @State private var selectedImage: Image?
    @State private var inputImage: UIImage?
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        selectedImage = Image(uiImage: inputImage)
    }
    
    func uiImageToString(from image: UIImage, cq: CGFloat = 0.8) -> String? {
        if let data = image.jpegData(compressionQuality: cq) {
            return data.base64EncodedString(options: .endLineWithLineFeed)
        } else if let data = image.pngData() {
            return data.base64EncodedString()
        }

        return nil
    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            EntryOptionView(
                image: "photo.circle.fill",
                option: "Photo"
            ) {
                Text("Une photo pour illustrer ta journée ?")
                    .italic()
                    .bold()
                    .opacity(0.5)
                
                Button {
                    showingImagePicker = true
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "plus.circle.fill")
                        Text("Choisi ta photo")
                            .font(.system(size: 12))
                            .bold()
                    }
                    .opacity(0.5)
                }
                
                if let selectedImage {
                    selectedImage
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    
                } else if entry.image! != "" {
                    Image(entry.image!)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }


            } optionAction: {
                if let picture = inputImage {
                    entry.image = uiImageToString(from: picture)
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) {
                loadImage()
            }

        }
    }
}

#Preview {
    PictureView(entry: entriesData[3])
}
