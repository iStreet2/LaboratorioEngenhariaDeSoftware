//
//  EditItemView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI

struct EditPerfilFeiranteView: View {
    
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        NavigationView{
            Form {
                TextField("Nome", text: $vm.feiranteAtual.nome)
                TextField("Email", text: $vm.feiranteAtual.email)
                TextField("Telefone", text: $vm.feiranteAtual.telefone)
                TextField("Nome da Barraca", text: $vm.feiranteAtual.nomeBanca)
                TextField("Desrição da Barraca", text: $vm.feiranteAtual.descricao)
                TextField("Tipos de Produto", text: $vm.feiranteAtual.tiposDeProduto)
            }
            .navigationTitle("Editar Item")
            .navigationBarItems(leading: Button("Cancelar") { dismiss() })
            .navigationBarItems(trailing:
                                    Button("Salvar") {
                // Chamando a função editarProtudo
                vm.editarFeirante(feirante: vm.feiranteAtual) { success in //Atualizo no banco de dados o que eu ja atualizei na minha ViewModel do feirante atual
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


//#Preview {
//    EditPerfilFeiranteView()
//}
