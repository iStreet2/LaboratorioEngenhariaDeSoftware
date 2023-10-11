//
//  Teste.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 11/10/23.
//

import SwiftUI
import Firebase


struct Teste: View {
    @EnvironmentObject var vm: ViewModel
    
    
    
    var body: some View {
        Button(action: {
            let cliente = Cliente(nome: "Guilherme", email: "bobao.com", telefone: "11", senha: "souBobao", predio: "dedas", apartamento: "sdwadsa")
            vm.addCliente(cliente: cliente)
            
        }, label: {
            Text("Botão")
        })
        
        Button(action: {
            vm.deleteCliente(id: "RAEvIGgXbsnlgUwMvnWK")
            
        }, label: {
            Text("Deletar")
        })
    }
}

#Preview {
    Teste()
        .environmentObject(ViewModel())
}
