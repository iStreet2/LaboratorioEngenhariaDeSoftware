//
//  EditItemView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI

struct EditItemView: View {
    
    @State private var nome: String = ""
    @State private var descricao: String = ""
    @State private var preco: String = ""
    @State private var quantidade: String = ""
    
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var produto: Produto
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Nome", text: $nome)
                TextField("Descrição", text: $descricao)
                TextField("Preço", text: $preco)
                    .keyboardType(.decimalPad) // Teclado numérico para inserção do preço
                TextField("Quantidade", text: $quantidade)
                    .keyboardType(.numberPad) // Teclado numérico para inserção da quantidade
            }
            .navigationTitle("Editar Item")
            .navigationBarItems(leading: Button("Cancelar") { dismiss() })
            .navigationBarItems(trailing:
                                    Button("Salvar") {
                let novoProduto = Produto(nome: nome, preco: preco, quantidade: Int(quantidade) ?? 0, descricao: descricao, feiranteEmail: vm.feiranteAtualEmail)
                // Chamando a função editarProtudo
                vm.editarProduto(nomeOriginal: produto.nome, novoProduto: novoProduto) { _ in }
                
                vm.fetchProdutosDoFeirante(emailFeirante: vm.feiranteAtualEmail){
                    print("\nPRODUTOS AQUI AAAAAA -> \(vm.produtos)\n")
                    dismiss()
                }
            }
            )
        }
        .onAppear{
            self.nome = produto.nome
            self.descricao = produto.descricao
            self.preco = produto.preco
            self.quantidade = String(produto.quantidade)
        }
    }
    
}


//#Preview {
//    EditItemView()
//}
