//
//  CartView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var vm: ViewModel
    @State var sheet = false
    
    @State var feirante: Feirante = Feirante(nome: "", email: "", telefone: "", senha: "", nomeBanca: "", tiposDeProduto: "", descricao: "")

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    ForEach(0 ..< vm.pedidosCliente.count, id: \.self){ i in
                        if vm.pedidosClienteLoaded {
                            PedidoView(nome: vm.pedidosCliente[i].produtoNome, estado: vm.pedidosCliente[i].estado, quantidade: vm.pedidosCliente[i].quantidade, nomeCliente: vm.clienteAtual.nome, nomeFeirante: feirante.nome, tipo: 0)
                                .onAppear{
                                    vm.fetchFeiranteWithId(id: vm.pedidosCliente[i].feiranteId) { feirante in
                                        self.feirante = feirante ?? self.feirante
                                    }
                                }
                        }
                    }
                    if !vm.pedidosClienteLoaded{
                        ProgressView()
                    }else if vm.pedidosCliente.count == 0{
                        Text("Não há pedidos no momento!")
                    }
                }
            }
            .refreshable(action: {
                vm.pedidosClienteLoaded = false
                vm.fetchPedidosDoCliente(clienteId: vm.clienteAtual.id ?? "teste") { success in
                    if success {
                        vm.pedidosClienteLoaded = true
                    }
                }
            })
            .navigationTitle("Carrinho")
            .onAppear{
                vm.fetchPedidosDoCliente(clienteId: vm.clienteAtual.id ?? "teste" ){ success in
                    if success{
                        vm.pedidosClienteLoaded = true
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        sheet.toggle()
                    }) {
                        Image(systemName: "arrow.circlepath")
                    }
                }
            }
            .sheet(isPresented: $sheet){
                CartSheetHistoryView()
            }
        }
    }
}

#Preview {
    CartView()
        .environmentObject(ViewModel())
}
