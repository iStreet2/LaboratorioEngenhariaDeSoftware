//
//  PostCard.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI

struct BarracaCard: View {
    var nome: String
    var descricao: String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(nome)
                    .frame(alignment: .leading)
                    .bold()
                    .padding(.bottom)
                Spacer()
            }
            HStack{
                Text(descricao)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .frame(minWidth: 300,minHeight: 80)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
        .padding([.top, .horizontal])
    }
}

#Preview {
    BarracaCard(nome: "Barraca do seu jorge amigao de todos", descricao: "A melhor barraca que encontrará por aqui dsdadwadsadwadsadsa!")
}
