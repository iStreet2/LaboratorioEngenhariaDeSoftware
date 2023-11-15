//
//  FullFeiraView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 15/11/23.
//

import SwiftUI

struct FullFeiraView: View {
    @EnvironmentObject var vm: ViewModel
    @State var isShowingSheet = false
    @State var i: Int
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                VStack(alignment:.leading){
                    Group{
                        Text("Nome do feirante: \(vm.feirantes[i].nome)")
                        
                        Text("Descrição: \(vm.feirantes[i].descricao == "" ? "Essa barraca ainda não tem descrição" : vm.feirantes[i].descricao)")
                        
                        
                    }
                    .font(.title2)
                    .padding(.vertical,5)
                }
                .padding()
                VStack(alignment:.leading){
                    Text("Itens")
                        .font(.title)
                        .bold()
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0 ..< vm.produtos.count, id: \.self) { i in
                            NavigationLink {
                                VStack{
                                    Text("Hello World")
                                }
                            } label: {
                                ItemView(titulo: vm.produtos[i].nome, preco: vm.produtos[i].preco, quantidade: vm.produtos[i].quantidade)
                            }
                        }
                    }
                }
                .padding()
            }
        }.navigationTitle("\(vm.feirantes[i].nomeBanca == "" ? "Essa barraca ainda não possui um nome" : vm.feirantes[i].nomeBanca)")
        .onAppear{
            vm.fetchProdutosDoFeirante(emailFeirante: vm.feirantes[i].email){}
        }
        
    }
}

#Preview {
    FullFeiraView(i: 0)
        .environmentObject(ViewModel())
}
