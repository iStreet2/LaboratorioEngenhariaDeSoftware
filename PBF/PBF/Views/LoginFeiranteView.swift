//
//  LoginFeiranteView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI

import SwiftUI

struct LoginFeiranteView: View {
    @State var loginInput: String = ""
    @State var passwordInput: String = ""
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                // Login
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email")
                        .foregroundStyle(.gray)
                    TextField("", text: $loginInput)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                    
                    // Senha
                    
                    Text("Senha")
                        .foregroundStyle(.gray)
                    TextField("", text: $passwordInput)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 0.5)
                        )
                    
                    
                    //Botão para criar uma conta
                    NavigationLink() {
//                        CreateClientAccountView()
                    } label: {
                        Text("Criar conta")
                            .foregroundColor(.gray)
                            .underline()
                            .font(.system(size:13))
                    }
                }
                
                Spacer()
                // Botão para continuar
                NavigationLink("Login") {
                    FeirasView()
                }
                .buttonStyle(PBFButtonSyle())
                
            }
            .padding()
        }
    }
}

#Preview {
    LoginFeiranteView()
}
