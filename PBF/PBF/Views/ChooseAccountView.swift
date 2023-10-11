//
//  ChooseAccountView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI

struct ChooseAccountView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Selecione o seu tipo de conta")
                    .foregroundStyle(Color.gray)
                
                // MARK: Conectar com o Firebase
                // Botão para as views do feirante
                NavigationLink("Feirante"){
                    LoginFeiranteView()
                }
                .buttonStyle(PBFButtonSyle())
                
                // Botão para as views do cliente
                NavigationLink("Cliente"){
                    LoginClientView()
                }
                .buttonStyle(PBFButtonSyle())
            }
        }
    }
}

#Preview {
    ChooseAccountView()
}
