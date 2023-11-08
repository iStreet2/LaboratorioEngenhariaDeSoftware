//
//  AddItemSheetView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI
import PhotosUI

struct AddItemSheetView: View {
    
    @State private var nome: String = ""
    @State private var descricao: String = ""
    @State private var preco: String = ""
    @State private var quantidade: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nome", text: $nome)
                TextField("Descrição", text: $descricao)
                TextField("Preço", text: $preco)
                    .keyboardType(.decimalPad) // Teclado numérico para inserção do preço
                TextField("Quantidade", text: $quantidade)
                    .keyboardType(.numberPad) // Teclado numérico para inserção da quantidade
            }
            .navigationTitle("Adicionar Item")
            .navigationBarItems(leading: Button("Cancelar") { dismiss() })
            .navigationBarItems(trailing:
                Button("Salvar") {
                let novoProduto = Produto(nome: nome, preco: preco, quantidade: Int(quantidade) ?? 0, descricao: descricao, feiranteEmail: vm.feiranteAtualEmail)
                // Chamando a função createProduct
                vm.criarProduto(product: novoProduto){ _ in
                }
                withAnimation(.easeInOut){
                    vm.fetchProdutosDoFeirante(emailFeirante: vm.feiranteAtualEmail){
                        dismiss()
                    }
                }
            })
        }
    }
}

#Preview {
    AddItemSheetView()
}
