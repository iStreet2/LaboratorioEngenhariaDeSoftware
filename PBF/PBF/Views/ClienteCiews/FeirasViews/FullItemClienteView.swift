//
//  FullItemClienteView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 16/11/23.
//

import SwiftUI

struct FullItemClienteView: View {
    @EnvironmentObject var vm: ViewModel
    @State var isShowingSheet = false
    @State var f: Int //Indice do vetor do feirante
    @State var produto: Produto 
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Group{
                    VStack(alignment:.leading){
                        HStack{
                            Text("Nome:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text(produto.nome)
                            .font(.title2)
                        
                        HStack{
                            Text("Descrição:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text(produto.descricao)
                            .font(.title2)
                        HStack{
                            Text("Preço:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text("R$ \(produto.preco)")
                            .font(.title2)
                        HStack{
                            Text("Quantidade disponível:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text("\(produto.quantidade)")
                            .font(.title2)
                    }
                }
                .padding()
                .cornerRadius(20)
                .padding()
            }
            .navigationTitle("Detalhes")
            
            Button(action: {
                
                isShowingSheet.toggle()
            }, label: {
                Text("Começar pedido!")
            })
            .buttonStyle(PBFButtonSyle())
        }
        .sheet(isPresented: $isShowingSheet) {
            FazerPedidoSheetView(f: f, produto: produto)
        }
        .onAppear{
            vm.produtosLoaded = false
        }
    }
        
}


#Preview {
    FullItemClienteView(f: 0, produto: ViewModel().produtos[0])
        .environmentObject(ViewModel())
}
