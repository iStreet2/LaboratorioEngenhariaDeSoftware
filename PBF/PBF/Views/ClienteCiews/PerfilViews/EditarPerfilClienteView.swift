//
//  EditItemView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI

struct EditarPerfilClienteView: View {
    
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        NavigationView{
            Form {
                TextField("Nome", text: $vm.clienteAtual.nome)
                TextField("Email", text: $vm.clienteAtual.email)
                TextField("Telefone", text: $vm.clienteAtual.telefone)
                TextField("Prédio", text: $vm.clienteAtual.predio)
                TextField("Apartamento", text: $vm.clienteAtual.apartamento)
            }
            .navigationTitle("Editar Perfil")
            .navigationBarItems(leading: Button("Cancelar") { dismiss() })
            .navigationBarItems(trailing:
                                    Button("Salvar") {
                // Chamando a função editarProtudo
                vm.editarCliente(cliente: vm.clienteAtual) { success in //Atualizo no banco de dados o que eu ja atualizei na minha ViewModel do feirante atual
                    if success{
                        dismiss()
                    }else{
                        print("Falha ao atualizar o feirante")
                    }
                }
            }
            )
        }
    }
    
}


#Preview {
    EditarPerfilClienteView()
        .environmentObject(ViewModel())
}
