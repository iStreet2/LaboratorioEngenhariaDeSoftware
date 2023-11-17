//
//  PedidosView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI

struct PedidosView: View {
    @EnvironmentObject var vm: ViewModel
    @State var sheet = false
    @State var sheet2 = false
    @State var cliente = Cliente(nome: "", email: "", telefone: "", senha: "", predio: "", apartamento: "")
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    ForEach(0 ..< vm.pedidosFeirante.count, id: \.self){ i in
                        if vm.pedidosFeiranteLoaded {
                            Button(action: {
                                sheet2.toggle()
                            }, label: {
                                PedidoView(nome: vm.pedidosFeirante[i].produtoNome, estado: vm.pedidosFeirante[i].estado, quantidade: vm.pedidosFeirante[i].quantidade, nomeCliente: cliente.nome, nomeFeirante: vm.feiranteAtual.nome, tipo: 1)
                                    .foregroundColor(.black)
                            })
                            .sheet(isPresented: $sheet2){
                                EditarPedidoView(pedido:vm.pedidosFeirante[i])
                            }
                            .onAppear{
                                vm.fetchClienteWithId(id: vm.pedidosFeirante[i].clienteId) { cliente in
                                    self.cliente = cliente ?? self.cliente
                                }
                            }
                        }
                    }
                    if !vm.pedidosFeiranteLoaded{
                        ProgressView()
                    }else if vm.pedidosFeirante.count < 1{
                        Text("Não há pedidos no momento!")
                    }
                }
            }
            .refreshable(action: {
                vm.pedidosFeiranteLoaded = false
                vm.fetchPedidosDoCliente(clienteId: vm.clienteAtual.id ?? "teste") { success in
                    if success {
                        vm.pedidosFeiranteLoaded = true
                    }
                }
            })
            .navigationTitle("Pedidos")
            .onAppear{
                vm.fetchPedidosDoFeirante(feiranteId: vm.feiranteAtual.id ?? "teste" ){ success in
                    if success{
                        vm.pedidosFeiranteLoaded = true
                    }
                }
                //Pegar o nome do cliente
                
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
    PedidosView()
        .environmentObject(ViewModel())
}
