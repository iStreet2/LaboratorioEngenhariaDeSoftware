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
    @State var i: Int
    
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
                        Text(vm.produtos[i].nome)
                            .font(.title2)
                        
                        HStack{
                            Text("Descrição:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text(vm.produtos[i].descricao)
                            .font(.title2)
                        HStack{
                            Text("Preço:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text("R$ \(vm.produtos[i].preco)")
                            .font(.title2)
                        HStack{
                            Text("Quantidade disponível:")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        Text("\(vm.produtos[i].quantidade)")
                            .font(.title2)
                    }
                    .padding()
                    .cornerRadius(20)
                    .padding()
                }
                
            }
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
                EditItemView(i: i)
            }
        }
    }
}


#Preview {
    FullItemView(i: 0)
        .environmentObject(ViewModel())
}
