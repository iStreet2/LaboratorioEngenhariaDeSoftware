//
//  EditItemView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI

struct EditItemView: View {
    
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
    @State var quantidade = ""
    @State var i: Int
    var body: some View {
        NavigationView{
            Form {
                TextField("Nome", text: $vm.produtos[i].nome)
                TextField("Descrição", text: $vm.produtos[i].descricao)
                TextField("Preço", text: $vm.produtos[i].preco)
                    .keyboardType(.decimalPad) // Teclado numérico para inserção do preço
                TextField("Quantidade", text: $quantidade)
                    .keyboardType(.numberPad) // Teclado numérico para inserção da quantidade
            }
            .navigationTitle("Editar Item")
            .navigationBarItems(leading: Button("Cancelar") { dismiss() })
            .navigationBarItems(trailing:
                                    Button("Salvar") {
                // Chamando a função editarProtudo
                vm.produtos[i].quantidade = Int(quantidade) ?? 0
                vm.editarProduto(produto: vm.produtos[i]) { success in
                    if success{
                        dismiss()
                    }else{
                        print("Falha ao atualizar o produto")
                    }
                }
            }
            )
        }
        .onAppear{
            self.quantidade = String(vm.produtos[i].quantidade)
        }
    }
    
}


//#Preview {
//    EditItemView()
//}
