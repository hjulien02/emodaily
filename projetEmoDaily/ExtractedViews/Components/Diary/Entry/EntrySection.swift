//
//  EntrySection.swift
//  projetEmoDaily
//
//  Created by Apprenant 148 on 13/03/2026.
//

import SwiftUI

struct EntrySection<Content: View>: View {
    
    var title: String
    var subtitle: String? = ""
    
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading) {
                Text(title)
                
                if subtitle != "" {
                    Text(subtitle!)
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                }
            }
            content()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    EntrySection(title: "Comment s’est passée ta journée ?"){
        VStack(alignment: .leading, spacing: 12) {
            Text("Comment s’est passée ta journée ?")
        }
    }
}
