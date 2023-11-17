//
//  EditarPedidoView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 17/11/23.
//

import SwiftUI

struct EditarPedidoView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
    @State var pedido: Pedido
    
    @State var statusOptions = ["Em preparo", "Pronto", "Entregue"]
    
    
    var body: some View {
        NavigationView{
            VStack{
                Picker("Status", selection: $pedido.estado) {
                    ForEach(0 ..< 3) {
                        Text(self.statusOptions[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Text("Status selecionado: \(statusOptions[pedido.estado])")
                Spacer()
            }
            .navigationTitle("Editar estado")
            .navigationBarItems(leading: Button("Cancelar") { dismiss() })
            .navigationBarItems(trailing:
                                    Button("Salvar") {
                // Chamando a função editarPedido
                vm.editarPedido(pedido: pedido) { success in
                    if success{
                        vm.fetchPedidosDoFeirante(feiranteId: vm.feiranteAtual.id ?? ""){ success2 in
                            if success2{
                                dismiss()
                            }
                            else{
                                print("Falha ao pegar os pedidos do feirante!")
                            }
                        }
                    }else{
                        print("Falha ao atualizar o pedido")
                    }
                }
            }
            )
        }
        //        .onAppear{
        //            self.quantidade = String(vm.produtos[i].quantidade)
        //        }
    }
}

#Preview {
    EditarPedidoView(pedido: ViewModel().pedidosFeirante[0])
}
