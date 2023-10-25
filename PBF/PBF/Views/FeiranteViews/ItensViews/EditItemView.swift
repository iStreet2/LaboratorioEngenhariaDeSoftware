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
    
    @State var produto: Produto
    @State var quantidade = ""
    
    var body: some View {
        Text("hello world")
        //        NavigationView {
        //            Form {
        //                TextField("Nome", text: $produto.nome)
        //                TextField("Descrição", text: $produto.descricao)
        //                TextField("Preço", text: $produto.preco)
        //                    .keyboardType(.decimalPad) // Teclado numérico para inserção do preço
        //                TextField("Quantidade", text: $quantidade)
        //                    .keyboardType(.numberPad) // Teclado numérico para inserção da quantidade
        //            }
        //            .navigationTitle("Adicionar Item")
        //            .navigationBarItems(leading: Button("Cancelar") { dismiss() })
        //            .navigationBarItems(trailing:
        //                                    Button("Salvar") {
        //                let novoProduto = Produto(nome: produto.nome, preco: produto.preco, quantidade: Int(quantidade) ?? 0, descricao: produto.descricao, feiranteEmail: vm.feiranteAtualEmail)
        //                // Chamando a função createProduct
        //                vm.editarProduto(nomeOriginal: , novoProduto: <#T##Produto#>, completion: <#T##(Bool) -> ()#>)
        //                withAnimation(.easeInOut){
        //                    vm.fetchProdutosDoFeirante(emailFeirante: vm.feiranteAtualEmail)
        //                }
        //
        //                dismiss()
        //            }
        //            )
        //        }
        //        .onAppear{
        //            self.quantidade = String(produto.quantidade)
        //        }
        //    }
        
    }
}

//#Preview {
//    EditItemView()
//}
