//
//  EditItemView.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 25/10/23.
//

import SwiftUI

struct EditPerfilFeiranteView: View {
    
    @State var feirante: Feirante
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        NavigationView{
            Form {
                TextField("Nome", text: $feirante.nome)
                TextField("Email", text: $feirante.email)
                TextField("Telefone", text: $feirante.telefone)
                TextField("Nome da Barraca", text: $feirante.nomeBanca)
                TextField("Desrição da Barraca", text: $feirante.descricao)
                TextField("Tipos de Produto", text: $feirante.tiposDeProduto)
            }
            .navigationTitle("Editar Item")
            .navigationBarItems(leading: Button("Cancelar") { dismiss() })
            .navigationBarItems(trailing:
                                    Button("Salvar") {
                // Chamando a função editarProtudo
                vm.editarFeirante(feirante: feirante) { success in
                    if success{
                        dismiss()
                    }else{
                        print("Falha ao atualizar o produto")
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
