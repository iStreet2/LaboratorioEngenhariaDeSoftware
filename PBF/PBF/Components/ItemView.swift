//
//  ItemView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI

struct ItemView: View {
    var titulo: String
    var preco: String
    var quantidade: Int
    
    
    var body: some View {
        if titulo == ""{
            
        }else{
            VStack(alignment: .leading) {
                HStack{
                    Text(titulo)
                        .frame(alignment: .leading)
                        .bold()
                    Spacer()
                }
                Spacer()
                Text("R$\(preco)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("Quantidade: \(quantidade)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .frame(width:130,height: 80)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
            .padding([.top, .horizontal])
        }
    }
}
#Preview {
    ItemView(titulo: "doawjd0wa9", preco:"13,90",quantidade:10)
}
