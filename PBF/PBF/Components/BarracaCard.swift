//
//  PostCard.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI

struct BarracaCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            // Título
            Text("Nome da Barraca")
                .font(.system(size: 20))
                .foregroundStyle(.gray)
                .padding(.bottom, 10)
                
            
            // Imagem
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .frame(width: 180, height: 170)
            
            // Descrição
            Text("Descrição")
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .padding(.vertical, 10)
            
        }
        .padding(.vertical, 33)
        .padding(.horizontal, 15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 0.5)
        )
    }
}

#Preview {
    BarracaCard()
}
