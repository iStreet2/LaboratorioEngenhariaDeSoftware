//
//  FullItemView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI

struct FullItemView: View {
    @EnvironmentObject var vm: ViewModel
    @State var isShowingSheet = false
    @State var produto: Produto
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    VStack(alignment:.leading){
                        HStack{
                            Text("Nome:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text(produto.nome)
                            .font(.title2)
                    }
                    .padding()
                    .background(Color("Cinza"))
                    .cornerRadius(20)
                    
                    VStack(alignment:.leading){
                        HStack{
                            Text("Descrição:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text(produto.descricao)
                            .font(.title2)
                    }
                    .padding()
                    .background(Color("Cinza"))
                    .cornerRadius(20)
                    
                    VStack(alignment:.leading){
                        HStack{
                            Text("Preço:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text("R$ \(produto.preco)")
                            .font(.title2)
                    }
                    .padding()
                    .background(Color("Cinza"))
                    .cornerRadius(20)
                    
                    VStack(alignment:.leading){
                        HStack{
                            Text("Quantidade disponível:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text("\(produto.quantidade)")
                            .font(.title2)
                    }
                    .padding()
                    .background(Color("Cinza"))
                    .cornerRadius(20)
                }
            }
            .padding()
            .navigationTitle("Detalhes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingSheet.toggle()
                    }) {
                        Text("Editar")
                    }
                }
            }
            .sheet(isPresented: $isShowingSheet) {
                EditItemView(produto: produto)
            }
            
        }
        
    }
}


#Preview {
    FullItemView(produto: Produto(nome: "Mandioca", preco: "0,03", quantidade: 1, descricao: "Mano, uma mandioca muito boa para vc se deliciar comendo umas das maiores maravilhas do brasil", feiranteEmail: ""))
}
