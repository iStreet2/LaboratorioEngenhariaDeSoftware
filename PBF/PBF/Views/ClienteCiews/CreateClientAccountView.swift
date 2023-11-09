//
//  CreateClientAccountView.swift
//  PBF
//
//  Created by Laura C. Balbachan dos Santos on 10/10/23.
//

import SwiftUI
import CoreData

struct CreateClientAccountView: View {
    @State var nameInput: String = ""
    @State var emailInput: String = ""
    @State var passInput: String = ""
    @State var apInput: String = ""
    @State var buildingInput: String = ""
    @State var errorMessage: String = ""
    
    // Variáveis para a animação do botão
    @State private var isLoading = false
    @State private var isSuccess = false
    @State private var navigate = false
    
    @EnvironmentObject var vm: ViewModel
    
    @Environment(\.managedObjectContext) var context //Contexto, DataController
    @ObservedObject var myDataController: MyDataController //acessar funcoes do meu CoreData
    
    @FetchRequest(sortDescriptors: []) var clienteData: FetchedResults<ClienteData> //Receber os dados salvos no CoreData
    
    init(context: NSManagedObjectContext) {
        self.myDataController = MyDataController(context: context)
    }
    
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
                        Text("Apartamento")
                            .foregroundStyle(.gray)
                        TextField("", text: $apInput)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                        Text("Prédio")
                            .foregroundStyle(.gray)
                        TextField("", text: $buildingInput)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                    }
                    .padding()
                    Spacer()
                    VStack{
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        }
                        VStack {
                            if !isLoading {
                                Button("Criar Conta") {
                                    if emailInput.isEmpty || passInput.isEmpty {
                                        // Configura a mensagem de erro
                                        errorMessage = "Por favor, preencha todos os campos."
                                        return // Sai da função para evitar que o resto do código seja executado
                                    }
                                    
                                    // Limpa a mensagem de erro se os campos estiverem preenchidos
                                    errorMessage = ""
                                    
                                    withAnimation {
                                        isLoading = true
                                    }
                                    
                                    let cliente = Cliente(nome: nameInput, email: emailInput, telefone: "", senha: passInput, predio: apInput, apartamento: buildingInput)
                                    
                                    vm.addCliente(cliente: cliente) { success in
                                        if success {
                                            withAnimation {
                                                isSuccess = true
                                            }
                                        } else {
                                            withAnimation {
                                                isLoading = false
                                            }
                                        }
                                    }
                                    
                                    // Simulando sucesso após 2 segundos
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        withAnimation {
                                            isSuccess = true
                                        }
                                    }
                                }
                                .buttonStyle(PBFButtonSyle())
                            }
                            
                            if isLoading {
                                if isSuccess {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.green)
                                        .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                withAnimation {
                                                    navigate = true
                                                }
                                            }
                                        }
                                } else {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                                        .scaleEffect(1.5)
                                }
                            }
                        }
                        
                        NavigationLink("", destination: HomeViewCliente(context: context).navigationBarBackButtonHidden(true), isActive: $navigate)
                            .hidden()
                        
                    }
                    Spacer()
                }
                
                .navigationTitle("Cliente")
            }
        }
    }
}

#Preview {
    CreateClientAccountView(context: DataController().container.viewContext)
}
