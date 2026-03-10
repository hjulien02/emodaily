//
//  EcranNouvelleEntree.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 04/03/2026.
//

import SwiftUI

struct EcranNouvelleEntree: View {
    
    @State var entry: Entry
    @State var date: Date
    
    var rows = [GridItem(.adaptive(minimum: 24),spacing: 16), GridItem(.adaptive(minimum: 24), spacing: 16)]
    var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 24){
                Text("Nouvelle Entrée") //Titre

                //Bornes du picker
                let daysBefore = Calendar.current.date(byAdding: .day, value: -7, to: date)!
                let daysAfter  = Calendar.current.date(byAdding: .day, value: 7, to: date)!
                
                //Picker pour changer la date
                DatePicker("", selection: $date,
                           in: daysBefore...daysAfter,
                           displayedComponents: [.date])
                .fixedSize()
                .frame(maxWidth: .infinity, alignment: .center)

                //Contenu de l'entrée
                ScrollView{
                    VStack(alignment: .leading,spacing: 24){
                        
                        //SECTION EMOTION
                        VStack(alignment: .leading, spacing: 12){
                            Text("Comment s’est passée ta journée ?")
                            
                            VStack{
                                LazyHGrid(rows: rows, spacing: 24) {
                                    ForEach(Emotion.allCases){
                                        thisEmotion in
                                        
                                        EmotionButton(entry: entry, emotion: thisEmotion, emoji: "")
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20).fill(.green.opacity(0.2))
                                .stroke(Color.accentColor.opacity(0.1), lineWidth: 1))

                        } //SECTION EMOTION
                        .frame(maxWidth: .infinity)
                        
                        
                        //SECTION OPTIONS
                        VStack(alignment: .leading, spacing: 12){
                            VStack(alignment: .leading){
                                Text("Quelque chose à raconter ?")
                                Text("seulement si tu le veux...")
                                    .font(.system(size: 12))
                            }
                            
                            LazyVGrid(columns: columns) {
                                EntryOption(icone: "character.circle.fill", optionTitle: "note")
                                EntryOption(icone: "photo.circle.fill", optionTitle: "photo")
                            }
                            
                        } //SECTION OPTIONS
                        .frame(maxWidth: .infinity)
                        
                        
                        //SECTION SANTE
                        VStack(alignment: .leading,spacing: 12){
                            Text("Et ta santé dans l’histoire ?")
                            
                            VStack(spacing: 22){
                                HealthSlider()
                                HealthSlider()
                                HealthSlider()
                                HealthSlider()
                            }

                        } //SECTION SANTE
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.red.opacity(0.2))
                        
                        // CTA
                        Button{

                        }label: {
                            Text("Enregistrer")
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
    }
}

#Preview {
    EcranNouvelleEntree(entry: entriesData[0], date: entriesData[0].date)
}
