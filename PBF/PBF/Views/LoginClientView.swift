//
//  LoginView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI

struct LoginClientView: View {
    @State var loginInput: String = ""
    @State var passwordInput: String = ""
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                // Login
                VStack(alignment: .leading, spacing: 10) {
                    Text("Login")
                        .foregroundStyle(.gray)
                    TextField("", text: $loginInput)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                }
                
                // Senha
                VStack(alignment: .leading, spacing: 10) {
                    Text("Senha")
                        .foregroundStyle(.gray)
                    TextField("", text: $passwordInput)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                }
                
                // Botão para criar uma conta
//                NavigationLink("Continuar") {
//                    BarracasView()
//                }
//                .buttonStyle(PBFButtonSyle())
                
                // Botão para continuar
                NavigationLink("Continuar") {
                    FeirasView()
                }
                .buttonStyle(PBFButtonSyle())
                
            }
            .padding()
        }
    }
}

#Preview {
    LoginClientView()
}
