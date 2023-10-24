//
//  CreateClientAccountView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI

struct CreateClientAccountView: View {
    @State var nameInput: String = ""
    @State var emailInput: String = ""
    @State var passInput: String = ""
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    VStack(alignment: .leading){
                        Text("Nome")
                            .foregroundStyle(.gray)
                        TextField("", text: $nameInput)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        Text("Email")
                            .foregroundStyle(.gray)
                        TextField("", text: $emailInput)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        Text("Senha")
                            .foregroundStyle(.gray)
                        TextField("", text: $passInput)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                    }
                    .padding()
                    VStack{
                        NavigationLink("Criar Conta"){
                            ContentView()
                                .navigationBarBackButtonHidden(true)
                        }
                        .buttonStyle(PBFButtonSyle())
                    }
                }
                .navigationTitle("Cliente")
            }
        }
    }
}

#Preview {
    CreateClientAccountView()
}
