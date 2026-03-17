//
//  UserAlert.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 17/03/2026.
//

import SwiftUI

struct UserAlert: View {
    
    @Binding var showAlert: Bool
    
    var title: String
    var message: String
    var cancel: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            VStack(alignment: .center, spacing: 4){
                Text("🤔")
                    .font(.system(size: 24))
                    .padding(.top, 8)

                Text(title)
                    .font(.system(size: 20))
                    .bold()
                    .lineLimit(1, reservesSpace: true)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, alignment: .top)
            
            Text(message)
                .font(.system(size: 16))
                .lineLimit(3, reservesSpace: true)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
            
            Button {
                showAlert = false
            } label: {
                Text(cancel)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(
                        RoundedRectangle(cornerRadius: 20).fill(.green15)
                            .stroke(.white.opacity(0.4), lineWidth: 2)
                    )
                    .foregroundStyle(.green4)
                    .bold()
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .foregroundStyle(.white)
        .padding()
        .background(.green4)
        .cornerRadius(24)
        .shadow(color: .background ,radius: 12)
        .padding()
    }
}


#Preview {
    @Previewable @State var showAlert: Bool = false


    UserAlert(showAlert: $showAlert, title: "Tu n'as pas donné ton mood !", message: "Renseigne ton humeur de la journée avant d'enregistrer", cancel: "J'y vais de ce pas")
}
