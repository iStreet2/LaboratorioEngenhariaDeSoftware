//
//  FazerPedidoSheetView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 16/11/23.
//

import SwiftUI

struct FazerPedidoSheetView: View {
    
    // Variáveis para a animação do botão
    @State private var isLoading = false
    @State private var isSuccess = false
    
    @State private var quantidade: String = ""
    @State private var observacao: String = ""
    @State private var showError = false // Nova variável para mostrar erro
    @State private var notEnough = false
    @State private var cantZero = false
    
    @State var f: Int //Indice do vetor do feirante
    @State var produto: Produto
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        NavigationView {
            ZStack{
                
                VStack {
                    Form {
                        TextField("Quantidade", text: $quantidade)
                            .keyboardType(.numberPad) // Teclado numérico para inserção da quantidade
                        TextField("Observação", text: $observacao)
                    }
                }
                if showError {
                    Text("Preencha o campo de quantidade!")
                        .foregroundColor(.red)
                }
                if notEnough{
                    VStack{
                        Text("Não há essa quantidade disponível no momento!")
                            .foregroundColor(.red)
                        Text("Quantidade disponível: \(produto.quantidade)")
                    }
                }
                if cantZero{
                        Text("Você não pode pedir por 0 de quantidade!")
                            .foregroundColor(.red)
                }
            }
            .navigationTitle("Começar pedido!")
            .navigationBarItems(leading: Button("Cancelar") { dismiss() })
            .navigationBarItems(trailing:
                                    Button(action: {
                if quantidade.isEmpty {
                    showError = true
                    return
                }
                else if Int(quantidade) ?? 0 > produto.quantidade{
                    notEnough = true
                    return
                }
                else if Int(quantidade) == 0{
                    cantZero = true
                    return
                }
                showError = false
                withAnimation {
                    isLoading = true
                }
                let pedido = Pedido(produtoId: produto.id!, produtoNome: produto.nome, clienteId: vm.clienteAtual.id!, feiranteId: vm.feirantes[f].id!, quantidade: Int(quantidade) ?? 0, observacao: observacao, estado: 0)
                
                vm.addPedido(pedido: pedido) { success in
                    if success {
                        isSuccess = true
                        produto.quantidade -= Int(quantidade) ?? 0
                        vm.editarProduto(produto: produto) { _ in
                        }
                    } else {
                        isLoading = false
                    }
                }
                
            }, label: {
                if isLoading {
                    if isSuccess {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    withAnimation {
                                        dismiss()
                                    }
                                }
                            }
                    } else {
                        ProgressView()
                    }
                } else {
                    Text("Fazer pedido!")
                }
            })
            )
        }
    }
}

#Preview {
    FazerPedidoSheetView(f: 0, produto: ViewModel().produtos[0])
}
