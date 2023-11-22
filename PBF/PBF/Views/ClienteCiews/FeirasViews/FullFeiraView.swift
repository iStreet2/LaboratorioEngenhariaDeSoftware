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
    @State var f: Int
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                VStack(alignment:.leading){
                    Group{
                        Text("Nome do feirante:")
                            .bold()
                        Text(vm.feirantes[f].nome)
                        Text("Descrição:")
                            .bold()
                        Text("\(vm.feirantes[f].descricao == "" ? "Essa barraca ainda não tem descrição" : vm.feirantes[f].descricao)")
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
                        ForEach(0 ..< vm.produtos.count, id: \.self) { p in
                            NavigationLink {
                                VStack{
                                    FullItemClienteView(f: f, p: p)
                                }
                            } label: {
                                if vm.produtosLoaded{
                                    ItemView(titulo: vm.produtos[p].nome, preco: vm.produtos[p].preco, quantidade: vm.produtos[p].quantidade)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            if !vm.produtosLoaded{
                ProgressView()
            }
        }
        .navigationTitle("\(vm.feirantes[f].nomeBanca == "" ? "Essa barraca ainda não possui um nome" : vm.feirantes[f].nomeBanca)")
        .onAppear{
            if !vm.produtosLoaded{
                vm.fetchProdutosDoFeirante(emailFeirante: vm.feirantes[f].email){ success in
                    if success{
                        vm.produtosLoaded = true
                    }
                }
            }
        }
        .refreshable {
            vm.produtosLoaded = false
            vm.fetchProdutosDoFeirante(emailFeirante: vm.feirantes[f].email){ success in
                if success{
                    vm.produtosLoaded = true
                }
                
            }
        }
        
    }
}

#Preview {
    FullFeiraView(f: 0)
        .environmentObject(ViewModel())
}
