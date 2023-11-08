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
    
    @State var produto: Produto
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Nome", text: $produto.nome)
                TextField("Descrição", text: $produto.descricao)
                TextField("Preço", text: $produto.preco)
                    .keyboardType(.decimalPad) // Teclado numérico para inserção do preço
                TextField("Quantidade", text: $quantidade)
                    .keyboardType(.numberPad) // Teclado numérico para inserção da quantidade
            }
            .navigationTitle("Editar Item")
            .navigationBarItems(leading: Button("Cancelar") { dismiss() })
            .navigationBarItems(trailing:
                                    Button("Salvar") {
                // Chamando a função editarProtudo
                produto.quantidade = Int(quantidade) ?? 0
                vm.editarProduto(produto: produto) { success in
                    if success{
                        vm.fetchProdutosDoFeirante(emailFeirante: vm.feiranteAtualEmail){
                            print("\nPRODUTOS AQUI AAAAAA -> \(vm.produtos)\n")
                            dismiss()
                        }
                    }else{
                        print("Falha ao atualizar o produto")
                    }
                }
            }
            )
        }
        .onAppear{
            self.quantidade = String(produto.quantidade)
        }
    }
    
}


//#Preview {
//    EditItemView()
//}
