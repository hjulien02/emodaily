//
//  ImageUpload.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 16/03/2026.
//

import Foundation
import SwiftUI

let cloudName: String = "duza6a8fg"
let uploadPreset: String = "emodaily_upload"

func uploadImage(_ image: UIImage) async throws -> URL {

    guard let imageData = image.jpegData(compressionQuality: 0.8) else {
        throw URLError(.badURL)
    }

    let url = URL(string: "https://api.cloudinary.com/v1_1/\(cloudName)/image/upload")!

    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    let boundary = UUID().uuidString
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    var body = Data()

    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"upload_preset\"\r\n\r\n".data(using: .utf8)!)
    body.append("\(uploadPreset)\r\n".data(using: .utf8)!)

    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
    body.append(imageData)
    body.append("\r\n".data(using: .utf8)!)

    body.append("--\(boundary)--\r\n".data(using: .utf8)!)

    request.httpBody = body
    do {
        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
            let result = try decoder.decode(CloudinaryResponse.self, from: data)
            if result.secure_url != "" {
                print("Image uploadée: \(result.secure_url)")
            } else {
                   print("Pas de secure_url dans la réponse")
               }
        return URL(string: result.secure_url)!
    } catch {
        print("Échec du décodage Image: \(error)")
        throw error
    }


}
