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
    @State var p: Int
    
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
                        Text(vm.produtos[p].nome)
                            .font(.title2)
                        
                        HStack{
                            Text("Descrição:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text(vm.produtos[p].descricao)
                            .font(.title2)
                        HStack{
                            Text("Preço:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text("R$ \(vm.produtos[p].preco)")
                            .font(.title2)
                        HStack{
                            Text("Quantidade disponível:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text("\(vm.produtos[p].quantidade)")
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
            FazerPedidoSheetView(f: f, p: p)
        }
    }
        
}


#Preview {
    FullItemClienteView(f: 0, p: 0)
        .environmentObject(ViewModel())
}
