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
            let cliente = Cliente(nome: "Sabrina", email: "sabrinaLinda.com", telefone: "soumuitolinda", senha: "soubobona", predio: "correia sampaio 864", apartamento: "32")
            vm.addCliente(cliente: cliente){_ in 
                
            }
            
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
