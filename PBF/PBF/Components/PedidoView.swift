//
//  PedidoView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 16/11/23.
//

import SwiftUI

struct PedidoView: View {
    var nome: String
    var estado: Int
    var quantidade: Int
    var nomeCliente: String
    var nomeFeirante: String
    var tipo: Int
    
    
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
                Text("Quantidade requisitada: \(quantidade)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            if tipo == 0{
                Text("Feirante: \(nomeFeirante)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            if tipo == 1{
                Text("Cliente: \(nomeCliente)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            Text("Preparo: \(estado == 0 ? "Em Preparo!" : estado == 1 ? "Pronto" : "Entregue")")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
            
            ZStack{
                if estado == 0{
                    HStack{
                        RoundedRectangle(cornerRadius:10)
                            .frame(width: 340/2, height: 20)
                            .foregroundColor(.yellow)
                        Spacer()
                    }
                    
                }else if estado == 1{
                    RoundedRectangle(cornerRadius:10)
                        .frame(width: 340, height: 20)
                        .foregroundColor(.green)
                }else{
                    RoundedRectangle(cornerRadius:10)
                        .frame(width: 340, height: 20)
                        .foregroundColor(.gray)
                }
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                    .frame(width: 340, height: 20)
            }
        }
        .frame(minWidth: 300,minHeight: 80)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
        .padding([.top, .horizontal])
    }
}

#Preview {
    PedidoView(nome: "Espetinho de Chocolate", estado: 0, quantidade: 1, nomeCliente: "Paulo", nomeFeirante: "Alberto", tipo: 0)
}
